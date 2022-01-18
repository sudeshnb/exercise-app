import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/size/size_config.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/database/app_db.dart';
import 'package:exercise_app/data/model/alarm.dart';
import 'package:exercise_app/main.dart';
import 'package:exercise_app/pages/profile/widgets/weekdays_picker.dart';
import 'package:exercise_app/widgets/custom_circle_button.dart';
import 'package:exercise_app/widgets/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<Alarm> arlams = [];
  List repeat = [];
  bool _switchValue = true;
  late DateTime alarmTime;
  bool isLoading = false;
  @override
  void initState() {
    alarmTime = DateTime.now();
    refreshNotes();
    super.initState();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    arlams = await ExerciseDatabase.instance.showAll();

    setState(() => isLoading = false);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 6.2 * SizeConfig.height!,
        leading: CustomCircleButton(
          onTap: () {
            Navigator.pop(context);
          },
          imagePath: 'back.png',
        ),
        title: Text(
          'Reminders',
          style: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 2.9 * SizeConfig.text!,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: arlams.isNotEmpty
          ? CustomPicker(
              child: ListView(
                children: arlams.map<Widget>((remind) {
                  var time = DateFormat().add_jm().format(remind.remindTime);

                  return Container(
                    height: 16 * SizeConfig.height!,
                    margin: EdgeInsets.all(2.3 * SizeConfig.height!),
                    padding: EdgeInsets.symmetric(
                        horizontal: 3 * SizeConfig.width!,
                        vertical: 1.5 * SizeConfig.height!),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius:
                          BorderRadius.circular(1.5 * SizeConfig.height!),
                      boxShadow: [
                        BoxShadow(
                          color: blueShadow.withOpacity(0.5),
                          offset: const Offset(1, 5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              time,
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 3 * SizeConfig.text!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                activeColor: blue,
                                value: _switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Repeat',
                                  style: TextStyle(
                                    color: black.withOpacity(0.6),
                                    fontSize: 2.2 * SizeConfig.text!,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                h10,
                                SizedBox(
                                  height: 4 * SizeConfig.height!,
                                  width: 30 * SizeConfig.height!,
                                  child: FutureBuilder<List<RepateArlam>>(
                                      future: ExerciseDatabase.instance
                                          .readArlam(remind.weekID),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          var data = snapshot.data!;
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.length,
                                            // itemCount: repeat.length,
                                            itemBuilder: (context, index) {
                                              var endItem = data.length - 1;
                                              return Text(
                                                '${data[index].week.substring(0, 3)}${endItem == index ? '' : ','}',
                                                style: TextStyle(
                                                  color:
                                                      darkBlue.withOpacity(0.7),
                                                  fontSize:
                                                      1.8 * SizeConfig.text!,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return WeekDaysPicker(
                                            callBack: (p0) {
                                              setState(() {
                                                repeat = p0;
                                              });
                                            },
                                          );
                                        });
                                  },
                                  child: Image.asset(
                                    'assets/icons/edit.png',
                                    height: 3 * SizeConfig.height!,
                                    color: darkBlue.withOpacity(0.8),
                                  ),
                                ),
                                w20,
                                GestureDetector(
                                  onTap: () async {
                                    await ExerciseDatabase.instance
                                        .delete(remind.id!);
                                    refreshNotes();
                                    // setState(() => alarm.remove(alarms));
                                  },
                                  child: Image.asset(
                                    'assets/icons/delete.png',
                                    height: 3 * SizeConfig.height!,
                                    // color: red.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/bell.png',
                    color: blue.withOpacity(0.5),
                    scale: 0.2,
                    height: 10 * SizeConfig.height!,
                  ),
                  h40,
                  Text(
                    'Please set your reminder',
                    style: TextStyle(
                      color: darkBlue.withOpacity(0.6),
                      fontSize: 3 * SizeConfig.text!,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () async {
          var selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (selectedTime != null) {
            final now = DateTime.now();
            var selectedDateTime = DateTime(now.year, now.month, now.day,
                selectedTime.hour, selectedTime.minute);

            await showDialog(
                context: context,
                builder: (context) {
                  return WeekDaysPicker(
                    callBack: (p0) {
                      setState(() {
                        repeat = p0;
                      });
                    },
                  );
                });
            //  setState(() {
            alarmTime = selectedDateTime;
            // addAlarm(alarmTime);
            var insertArlam = Alarm(
                isOn: true,
                remindTime: alarmTime,
                weekID: now.toIso8601String());
            for (int i = 0; i < repeat.length; i++) {
              var insertRepeat = RepateArlam(
                week: repeat[i],
                weekID: now.toIso8601String(),
              );
              ExerciseDatabase.instance.insertRepeat(insertRepeat);
            }

            scheduleNotification(alarmTime, 0);
            ExerciseDatabase.instance.insertArlam(insertArlam);
            refreshNotes();
            //  });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void alarmStop(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future alarmOn(int id, DateTime scheduledTime) async {
    DateTime scheduleAlarmDateTime;
    if (scheduledTime.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = scheduledTime;
    } else {
      scheduleAlarmDateTime = scheduledTime.add(const Duration(days: 1));
    }
    scheduleNotification(scheduleAlarmDateTime, id);
  }

  Future<void> scheduleNotification(DateTime dateTime, int id) async {
    const androidChannel = AndroidNotificationDetails(
      '0',
      'reminder',
      channelDescription: 'Exercise Reminder Notification',
      icon: 'logo',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('logo'),
    );

    const channelSpecifics = NotificationDetails(android: androidChannel);
    await flutterLocalNotificationsPlugin.show(
      id,
      'Hello',
      'I\'ll Remind you about the planned workout',
      channelSpecifics,
      payload: 'Test Payload',
    );
  }
}
