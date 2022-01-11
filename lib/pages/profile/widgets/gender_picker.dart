import 'dart:ui';

import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/dialog_box_button.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  final Function(String) gender;
  const GenderPicker({Key? key, required this.gender}) : super(key: key);

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  late int groupValue = 1;
  String genderN = 'Male';
  void selectedGender(int value, String gender) {
    setState(() {
      groupValue = value;
      genderN = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select your gender',
              style: TextStyle(
                color: black.withOpacity(0.7),
                fontSize: 20.0,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            h20,
            Text(
              'Select your gender below to recognize yourself.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black.withOpacity(0.4),
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            h20,
            ListTile(
              title: const Text('Male'),
              leading: Radio(
                  value: 1,
                  groupValue: groupValue,
                  activeColor: blue,
                  onChanged: (int? value) {
                    selectedGender(value!, 'Male');
                  }),
            ),
            ListTile(
              title: const Text('Female'),
              leading: Radio(
                  value: 2,
                  groupValue: groupValue,
                  activeColor: blue,
                  onChanged: (int? value) {
                    selectedGender(value!, 'Female');
                  }),
            ),
            h30,
            DialogBoxButton(
              onTap: () {
                widget.gender(genderN);
                Navigator.pop(context);
              },
              btnTxt: 'Coutinue',
            ),
            DialogBoxButton(
              onTap: () {
                Navigator.pop(context);
              },
              fontColor: darkBlue,
              color: red.withOpacity(0.7),
              btnTxt: 'Cancel',
            ),
          ],
        ),
      ),
    );
  }
}
