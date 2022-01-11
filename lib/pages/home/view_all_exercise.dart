import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/level_model.dart';
import 'package:exercise_app/widgets/custom_circle_button.dart';
import 'package:exercise_app/widgets/custom_round_btn.dart';
import 'package:exercise_app/widgets/picker.dart';
import 'package:flutter/material.dart';

class ViewAllExercise extends StatefulWidget {
  final Levels level;
  const ViewAllExercise({Key? key, required this.level}) : super(key: key);

  @override
  _ViewAllExerciseState createState() => _ViewAllExerciseState();
}

class _ViewAllExerciseState extends State<ViewAllExercise> {
  late int editSecond, stableValue;
  @override
  void initState() {
    editSecond = stableValue = int.parse(widget.level.exercise[0].time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: CustomPicker(
          child: Stack(
            children: [
              Container(
                height: height / 2.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.level.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              CustomCircleButton(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/BottomNavBar', (route) => false);
                },
                imagePath: 'back.png',
              ),
              Container(
                height: height,
                width: double.infinity,
                margin: EdgeInsets.only(top: height / 3.2),
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.level.title,
                      style: TextStyle(
                        color: black.withOpacity(0.7),
                        fontSize: 25.0,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    h10,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/icons/gas.png',
                          height: 25,
                          color: orange,
                        ),
                        w10,
                        Text(
                          '${widget.level.kcal} Kcal',
                          style: const TextStyle(
                            color: grey,
                            fontSize: 16.0,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        w20,
                        Image.asset(
                          'assets/icons/time.png',
                          height: 25,
                          color: blue,
                        ),
                        w10,
                        Text(
                          '${widget.level.time} Min',
                          style: const TextStyle(
                            color: grey,
                            fontSize: 16.0,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    h10,
                    Text(
                      'Rest between exercises',
                      style: TextStyle(
                        color: black.withOpacity(0.7),
                        fontSize: 18.0,
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    h20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  editSecond.toString(),
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 40.0,
                                    letterSpacing: 0.9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'seconds',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 17.0,
                                    letterSpacing: 0.9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            w10,
                            Column(
                              children: [
                                secondUpDownBtn(
                                    onTap: () {
                                      setState(() => editSecond++);
                                    },
                                    image: 'up.png'),
                                h10,
                                secondUpDownBtn(
                                    onTap: () {
                                      if (stableValue < editSecond) {
                                        setState(() => editSecond--);
                                      }
                                    },
                                    image: 'down.png'),
                              ],
                            ),
                          ],
                        ),
                        CustomRoundBtn(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/ReadyPage',
                              arguments: widget.level,
                            );
                          },
                          text: 'Start Workout',
                        )
                      ],
                    ),
                    h20,
                    Center(
                      child: Text(
                        '${widget.level.exercise.length} Exercises',
                        style: TextStyle(
                          color: black.withOpacity(0.7),
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                    h10,
                    const Divider(
                      thickness: 1,
                      color: darkBlue,
                    ),
                    h10,
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.level.exercise.length,
                        itemBuilder: (itemBuilder, index) {
                          final exer = widget.level.exercise[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                '/ExerciseDetailsPage',
                                arguments: exer,
                              );
                            },
                            child: Container(
                              height: 60.0,
                              color: white,
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(exer.imagePath),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: grey,
                                    ),
                                  ),
                                  w10,
                                  Text(
                                    '${exer.time}s',
                                    style: const TextStyle(
                                      color: grey,
                                      letterSpacing: 0.9,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  w30,
                                  Text(
                                    exer.name,
                                    style: TextStyle(
                                      color: black.withOpacity(0.7),
                                      letterSpacing: 0.9,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget secondUpDownBtn({required String image, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        child: Center(
          child: Image.asset(
            'assets/icons/$image',
            color: white,
            height: 20,
          ),
        ),
        decoration: BoxDecoration(
          color: blue,
          boxShadow: [
            BoxShadow(
              color: blue.withOpacity(0.3),
              offset: const Offset(1, 1),
              blurRadius: 20,
            ),
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
