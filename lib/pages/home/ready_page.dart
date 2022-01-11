import 'dart:async';
import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/level_model.dart';
import 'package:exercise_app/pages/home/widgets/workout_timer.dart';
import 'package:exercise_app/pages/home/widgets/reset_timer.dart';
import 'package:exercise_app/pages/home/widgets/total_timer.dart';
import 'package:exercise_app/widgets/custom_circle_button.dart';
import 'package:exercise_app/widgets/dialog_box.dart';
import 'package:flutter/material.dart';

class ReadyPage extends StatefulWidget {
  final Levels level;

  const ReadyPage({Key? key, required this.level}) : super(key: key);

  @override
  State<ReadyPage> createState() => _ReadyPageState();
}

class _ReadyPageState extends State<ReadyPage> with TickerProviderStateMixin {
  late RestTimer restTimer = RestTimer(this);
  late TotalTimer totalTimer = TotalTimer(this);
  late WorkOutTimer workoutTimer = WorkOutTimer(this);

  PageController controller = PageController();
  int selectIndex = 0;
  int count = 4;
  bool isPlay = false;
  bool isPause = false;
  bool isDone = false;
  bool workOutStart = false;

  void timecount() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (count == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            isDone = true;
          });
          restTimer.restart();
        }
      } else {
        setState(() => count--);
      }
    });
  }

  void pauseAndRePlay() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (count == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
          });
          workoutTimer.start();
        }
      } else {
        setState(() => count--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 50,
        leading: CustomCircleButton(
          onTap: () {
            Navigator.pop(context);
          },
          imagePath: 'back.png',
        ),
        title: Text(
          widget.level.title,
          style: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/ExerciseDetailsPage',
                arguments: widget.level.exercise[selectIndex],
              );
            },
            icon: const Icon(
              Icons.menu,
              color: blue,
            ),
          )
        ],
      ),
      body: PageView.builder(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, position) {
          selectIndex = position;
          return Stack(
            children: [
              Column(
                children: [
                  h30,
                  Text(
                    widget.level.exercise[position].name,
                    style: const TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      letterSpacing: 0.7,
                    ),
                  ),
                  h10,
                  Text(
                    position < 9 && widget.level.exercise.length < 9
                        ? '0${position + 1} of 0${widget.level.exercise.length}'
                        : '${position + 1} of ${widget.level.exercise.length}',
                    style: const TextStyle(
                      color: grey,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7,
                      fontSize: 24.0,
                    ),
                  ),
                  h20,
                  Expanded(
                    child: Stack(
                      children: [
                        Image.asset(
                          widget.level.exercise[position].imagePath,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: isPause == true || count != 0
                              ? black.withOpacity(0.2)
                              : Colors.transparent,
                        )
                      ],
                    ),
                  )
                ],
              ),
              isPlay
                  ? count == 4
                      ? const Center(
                          child: Text(
                            'Get Ready',
                            style: TextStyle(
                              color: red,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.7,
                              fontSize: 50.0,
                            ),
                          ),
                        )
                      : count == 0
                          ? const SizedBox()
                          : Center(
                              child: Text(
                                count.toString(),
                                style: const TextStyle(
                                  color: blue,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.7,
                                  fontSize: 50.0,
                                ),
                              ),
                            )
                  : const SizedBox(),
              isPause
                  ? const Center(
                      child: Text(
                        'Pause',
                        style: TextStyle(
                          color: red,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          fontSize: 50.0,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        },
        itemCount: widget.level.exercise.length, // Can be null
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          color: white,
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              controlBtn(
                image: isPause ? 'stop' : 'pause',
                onTap: () {
                  if (isPause) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            title: 'End Workout',
                            subTitle:
                                "Are you sure you want to End current Workout session?",
                            onContinue: () {
                              Navigator.of(context).pushNamed(
                                '/ViewAllExercisePage',
                                arguments: widget.level,
                              );
                            },
                          );
                        });
                  }
                  if (isPlay) {
                    setState(() {
                      isPause = true;
                      isPlay = false;
                      isDone = false;
                      restTimer.pause();
                    });
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    count = 4;
                    isPlay = true;
                    isPause = false;
                  });
                  timecount();
                  pauseAndRePlay();
                },
                child: isPlay
                    ? Container(
                        height: 160.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: blueShadow.withOpacity(0.6),
                              offset: const Offset(0, 10),
                              blurRadius: 20.0,
                            )
                          ],
                          color: white,
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: workOutStart
                            ? CustomWorkOutTimer(
                                child: SizedBox(
                                  height: 70.0,
                                  width: 80.0,
                                  //This is a small circle
                                  child: smallcircletimer(),
                                ),
                                controller: workoutTimer,
                                duration:
                                    widget.level.exercise[selectIndex].duration,
                                timerStyle: WOTimerStyle.ring,
                                onStart: totalTimer.start,
                                onEnd: handleTimerOnEnd3,
                                backgroundColor: blue.withOpacity(0.2),
                                progressIndicatorColor: red.withOpacity(0.8),
                                progressIndicatorDirection:
                                    WOTimerProgressIndicatorDirection
                                        .counterClockwise,
                                progressTextCountDirection:
                                    WOTimerProgressTextCountDirection
                                        .singleCount,
                                progressTextStyle:
                                    const TextStyle(color: blue, fontSize: 45),
                                strokeWidth: 5,
                              )
                            : CustomTimer(
                                duration: const Duration(seconds: 5),
                                child: SizedBox(
                                  height: 70.0,
                                  width: 80.0,
                                  //This is a small circle
                                  child: smallcircletimer(),
                                ),
                                controller: restTimer,
                                timerStyle: TimerStyle.ring,
                                onStart: handleTimerOnStart,
                                onEnd: handleTimerOnEnd,
                                backgroundColor: blue.withOpacity(0.3),
                                progressIndicatorColor: darkBlue,
                                progressIndicatorDirection:
                                    TimerProgressIndicatorDirection.clockwise,
                                progressTextCountDirection:
                                    TimerProgressTextCountDirection.singleCount,
                                progressTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 50,
                                ),
                                strokeWidth: 5,
                              ),
                      )
                    : Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: blueShadow.withOpacity(0.6),
                              offset: const Offset(0, 10),
                              blurRadius: 20.0,
                            )
                          ],
                          color: white,
                          borderRadius: BorderRadius.circular(60.0),
                          border: Border.all(
                              color: blue.withOpacity(0.6), width: 1.2),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/play.png',
                            scale: 0.5,
                            color: darkBlue,
                            height: 60,
                          ),
                        ),
                      ),
              ),
              controlBtn(
                image: 'fast_forward',
                onTap: () {
                  //TODO: save data to database
                  skipButton();
                  setState(() {
                    controller.jumpToPage(selectIndex + 1);
                    isPlay = false;
                    workOutStart = false;
                    isPause = false;
                  });
                  if (selectIndex == widget.level.exercise.length - 1) {
                    Navigator.of(context).pushNamed(
                      '/CompletePage',
                      arguments: widget.level,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector controlBtn(
      {required String? image, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(60.0),
          border: Border.all(color: blue.withOpacity(0.6), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: blueShadow.withOpacity(0.6),
              offset: const Offset(0, 10),
              blurRadius: 20.0,
            )
          ],
        ),
        child: Image.asset(
          'assets/icons/$image.png',
          color: darkBlue,
          height: 35,
        ),
      ),
    );
  }

  CustomResetTimer smallcircletimer() {
    return CustomResetTimer(
      duration: widget.level.duration,
      controller: totalTimer,
      timerStyle: RTimerStyle.ring,
      onStart: workoutTimer.restart,
      onEnd: handleTimerOnEnd2,
      backgroundColor: blueShadow.withOpacity(0.2),
      progressIndicatorColor: blue,
      progressIndicatorDirection: RTimerProgressIndicatorDirection.clockwise,
      progressTextCountDirection: RTimerProgressTextCountDirection.countDown,
      progressTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
      strokeWidth: 5,
    );
  }

  void handleTimerOnStart() {
    setState(() => count = 4);
  }

  void handleTimerOnStart3() {
    totalTimer.start();
  }

  void handleTimerOnEnd() {
    setState(() {
      workOutStart = true;
      count = 0;
    });

    timerStarter();
  }

  bool isSecondRound = false;

  void timerStarter() {
    totalTimer.start();
    if (isSecondRound) {
      workoutTimer.restart();
    } else {
      setState(() => isSecondRound = true);
    }
  }

  void handleTimerOnEnd2() {
    restTimer.stop();
    totalTimer.stop();
    workoutTimer.stop();
    Navigator.of(context).pushNamed(
      '/CompletePage',
      arguments: widget.level,
    );
  }

  void skipButton() {
    setState(() {
      restTimer.stop();
      workoutTimer.stop();
      workoutTimer.reset();
    });
  }

  void handleTimerOnEnd3() {
    setState(() {
      totalTimer.pause();
      workOutStart = false;
      controller.jumpToPage(selectIndex + 1);
      restTimer.restart();
      workoutTimer.stop();
    });
    if (selectIndex == widget.level.exercise.length - 1) {
      restTimer.stop();
      totalTimer.stop();
      workoutTimer.stop();
      Navigator.of(context).pushNamed(
        '/CompletePage',
        arguments: widget.level,
      );
    }
  }

  @override
  void dispose() {
    restTimer.stop();
    totalTimer.stop();
    workoutTimer.stop();
    super.dispose();
  }
}
