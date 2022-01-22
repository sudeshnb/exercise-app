import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/size/size_config.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/database/app_db.dart';
import 'package:exercise_app/data/model/report.dart';
import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Reports> reports = [];
  List<Reports> history = [];
  int totWorkout = 0;
  double totKacl = 0.0, totTime = 0.0;

  @override
  void initState() {
    showData();
    super.initState();
  }

  Future showData() async {
    reports = await ExerciseDatabase.instance.showReports();

    calculateData();
    if (mounted) setState(() {});
  }

  void calculateData() async {
    for (int i = 0; i < reports.length; i++) {
      totWorkout = totWorkout + int.parse(reports[i].workouts);
      totKacl = totKacl + double.parse(reports[i].kcal);
      totTime = totTime + double.parse(reports[i].duration);
      var date =
          '${reports[i].time.year}${reports[i].time.month}${reports[i].time.day}';

      history = await ExerciseDatabase.instance.showHistory(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reports',
          style: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 2.9 * SizeConfig.text!,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2 * SizeConfig.height!,
          vertical: 3 * SizeConfig.height!,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(1.5 * SizeConfig.height!),
              height: 23 * SizeConfig.height!,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(1 * SizeConfig.height!),
                boxShadow: [
                  BoxShadow(
                    color: blueShadow.withOpacity(0.5),
                    blurRadius: 10.0,
                    spreadRadius: 1,
                    offset: const Offset(1, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Summary',
                    style: TextStyle(
                      color: darkBlue.withOpacity(0.7),
                      letterSpacing: 1,
                      fontSize: 2.5 * SizeConfig.text!,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: blue.withOpacity(0.5),
                  ),
                  h10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      reportTotalData(
                        name: 'Workouts',
                        imagePath: 'workout',
                        data: totWorkout.toString(),
                      ),
                      w40,
                      reportTotalData(
                        name: 'Kcal',
                        imagePath: 'gas',
                        data: totKacl.toStringAsFixed(0),
                      ),
                      w40,
                      reportTotalData(
                        name: 'Duraton',
                        imagePath: 'time',
                        data: totTime.toStringAsFixed(0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            h50,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    color: black.withOpacity(0.7),
                    letterSpacing: 1,
                    fontSize: 2.5 * SizeConfig.text!,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/HistoryPage');
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: darkBlue,
                  ),
                )
              ],
            ),
            h20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 6; i >= 0; i--) _getWeek(i),
              ],
            ),
            h40,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$count2 ',
                    style: TextStyle(
                      color: red.withOpacity(0.7),
                      fontSize: 2.5 * SizeConfig.text!,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' Day in a row',
                    style: TextStyle(
                      color: black.withOpacity(0.7),
                      fontSize: 2.5 * SizeConfig.text!,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column reportTotalData({
    required String name,
    required String imagePath,
    required String data,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 2.5 * SizeConfig.height!,
          backgroundColor: blue.withOpacity(0.3),
          child: Image.asset(
            'assets/icons/$imagePath.png',
            color: darkBlue,
            height: 2.6 * SizeConfig.height!,
          ),
        ),
        h10,
        Text(
          name,
          style: TextStyle(
            color: blue.withOpacity(0.9),
            letterSpacing: 1,
            fontSize: 1.9 * SizeConfig.text!,
            fontWeight: FontWeight.w600,
          ),
        ),
        h10,
        Text(
          data,
          style: TextStyle(
            color: black.withOpacity(0.6),
            letterSpacing: 1,
            fontSize: 2.2 * SizeConfig.text!,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }

  int count = 0;
  int count2 = 0;
  Widget _getWeek(int index) {
    var now = DateTime.now();
    var day = now.subtract(Duration(days: index));
    var dayName = _getWeekName(day);
    bool isFind = false;
    if (reports.isNotEmpty) {
      for (int i = 0; reports.length > i; i++) {
        if ('${day.month}${day.day}' ==
            '${reports[i].time.month}${reports[i].time.day}') {
          isFind = true;
          count++;
        }
      }
    }
    if (count > 0) {
      count2++;
    }

    return Column(
      children: [
        Text(dayName),
        h10,
        Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            color: isFind ? blueShadow : white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: blueShadow.withOpacity(0.5),
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: const Offset(1, 5),
              ),
            ],
          ),
          child: Center(
            child: isFind
                ? Image.asset(
                    'assets/icons/done.png',
                    color: white,
                    height: 20.0,
                  )
                : Text(
                    day.day.toString(),
                    style: TextStyle(
                      color: black.withOpacity(0.7),
                      fontSize: 18.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        )
      ],
    );
  }

  String _getWeekName(DateTime value) {
    var weekday = '';
    if (value.weekday == DateTime.monday) {
      weekday = 'Mon';
    } else if (value.weekday == DateTime.tuesday) {
      weekday = 'Tue';
    } else if (value.weekday == DateTime.wednesday) {
      weekday = 'Wed';
    } else if (value.weekday == DateTime.thursday) {
      weekday = 'Thu';
    } else if (value.weekday == DateTime.friday) {
      weekday = 'Fri';
    } else if (value.weekday == DateTime.saturday) {
      weekday = 'Sat';
    } else {
      weekday = 'Sun';
    }
    return weekday;
  }
}
