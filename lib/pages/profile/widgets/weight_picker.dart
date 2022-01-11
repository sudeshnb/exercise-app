import 'dart:ui';

import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/dialog_box_button.dart';
import 'package:exercise_app/widgets/picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeightPicker extends StatefulWidget {
  final Function(String) weight;
  const WeightPicker({Key? key, required this.weight}) : super(key: key);

  @override
  State<WeightPicker> createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  int weightValue = 1;
  int weightPointValue = 0;

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
                'Weight',
                style: TextStyle(
                  color: black.withOpacity(0.7),
                  fontSize: 20.0,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.w600,
                ),
              ),
              h20,
              Text(
                'Please select your weight it is also used for BMI calculations.',
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
                      width: 60.0,
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
                          setState(() => weightValue = value + 1);
                        },
                        itemBuilder: (itemBuilder, index) {
                          return Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 20.0,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    w10,
                    Text(
                      '.',
                      style: TextStyle(
                        color: black.withOpacity(0.7),
                        fontSize: 20.0,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    w10,
                    SizedBox(
                      width: 60.0,
                      child: CupertinoPicker.builder(
                        childCount: 10,
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
                          setState(() => weightPointValue = value);
                        },
                        itemBuilder: (itemBuilder, index) {
                          return Center(
                            child: Text(
                              index.toString(),
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 20.0,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    w10,
                    Container(
                      width: 60.0,
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: blue, width: 1),
                          bottom: BorderSide(color: blue, width: 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'kg',
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
                  widget.weight('$weightValue.$weightPointValue');
                  Navigator.pop(context);
                },
                btnTxt: 'Coutinue',
              ),
              DialogBoxButton(
                onTap: () {
                  Navigator.pop(context);
                },
                fontColor: darkBlue,
                color: blue.withOpacity(0.1),
                btnTxt: 'Cancel',
              ),
            ],
          ),
        ),
      ),
    );
  }
}