import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/pages/profile/widgets/weekdays_picker.dart';
import 'package:exercise_app/widgets/custom_circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List alarm = [];
  List repeat = [];
  String cha3 = '';
  bool _switchValue = true;
  late DateTime alarmTime;
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
          'Reminders',
          style: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: alarm.isNotEmpty
          ? ListView(
              children: alarm.map<Widget>((alarms) {
                var time = DateFormat().add_jm().format(alarmTime);
                return Container(
                  height: 120.0,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
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
                              fontSize: 24.0,
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
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              h10,
                              Row(
                                children: repeat.map<Widget>((e) {
                                  return Text(
                                    '${e[0]}${e[1]}${e[2]},',
                                    style: TextStyle(
                                      color: darkBlue.withOpacity(0.7),
                                      fontSize: 15.0,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList(),
                              )
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
                                  height: 30,
                                  color: darkBlue.withOpacity(0.8),
                                ),
                              ),
                              w20,
                              GestureDetector(
                                onTap: () {
                                  setState(() => alarm.remove(alarms));
                                },
                                child: Image.asset(
                                  'assets/icons/delete.png',
                                  height: 30,
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
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/bell.png',
                    color: blue.withOpacity(0.5),
                    scale: 0.2,
                    height: 80,
                  ),
                  h40,
                  Text(
                    'Please set your reminder',
                    style: TextStyle(
                      color: darkBlue.withOpacity(0.6),
                      fontSize: 22.0,
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

            setState(() {
              alarmTime = selectedDateTime;
              alarm.add(alarmTime);
            });
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
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
