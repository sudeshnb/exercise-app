import 'package:exercise_app/pages/report/history_calender.dart';
import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/widgets/custom_circle_button.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leadingWidth: 50,
        leading: CustomCircleButton(
          onTap: () {
            Navigator.pop(context);
          },
          imagePath: 'back.png',
        ),
        title: Text(
          'History',
          style: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const HistoryCalender(),
    );
  }
}
