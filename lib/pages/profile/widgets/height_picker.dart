import 'dart:ui';

import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/dialog_box_button.dart';
import 'package:exercise_app/widgets/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightPicker extends StatefulWidget {
  final Function(String) height;
  const HeightPicker({Key? key, required this.height}) : super(key: key);

  @override
  State<HeightPicker> createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  double heightValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: CustomPicker(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Height',
                style: TextStyle(
                  color: black.withOpacity(0.7),
                  fontSize: 20.0,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
              h20,
              Text(
                'Please select your height it is also used for BMI calculations.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: black.withOpacity(0.4),
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
              h20,
              SizedBox(
                height: 100.0,
                width: 220.0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: CupertinoPicker.builder(
                        childCount: 500,
                        itemExtent: 50,
                        selectionOverlay: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: blue, width: 1),
                              bottom: BorderSide(color: blue, width: 1),
                            ),
                          ),
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() => heightValue = 50.0 + value);
                        },
                        itemBuilder: (itemBuilder, index) {
                          return Text(
                            '${index + 50}',
                            style: TextStyle(
                              color: black.withOpacity(0.7),
                              fontSize: 20.0,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                    w20,
                    Container(
                      width: 100.0,
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: blue, width: 1),
                          bottom: BorderSide(color: blue, width: 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'cm',
                          style: TextStyle(
                            color: black.withOpacity(0.7),
                            fontSize: 20.0,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h30,
              DialogBoxButton(
                onTap: () {
                  widget.height(heightValue.toString());
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
      ),
    );
  }
}
