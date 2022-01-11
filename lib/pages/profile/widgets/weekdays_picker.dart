import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/dialog_box_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeekDaysPicker extends StatefulWidget {
  final Function(List) callBack;
  const WeekDaysPicker({Key? key, required this.callBack}) : super(key: key);

  @override
  State<WeekDaysPicker> createState() => _WeekDaysPickerState();
}

class _WeekDaysPickerState extends State<WeekDaysPicker> {
  List items = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Fridey',
    'Saturday'
  ];

  List selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Days',
              style: TextStyle(
                color: black.withOpacity(0.6),
                letterSpacing: 0.7,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            h20,
            Text(
              'Please select days it used to repeat reminders.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black.withOpacity(0.4),
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            h20,
            Expanded(
              child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: items.map((item) {
                    bool isSelected = selectedItems.contains(item);
                    return CheckboxListTile(
                      activeColor: blue,
                      checkColor: white,
                      title: Text(item),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedItems.add(item);
                          } else {
                            selectedItems.remove(item);
                          }
                        });
                      },
                    );
                  }).toList()),
            ),
            h30,
            DialogBoxButton(
              onTap: () {
                widget.callBack(selectedItems);
                Navigator.pop(context);
              },
              btnTxt: 'Continue',
            ),
            DialogBoxButton(
              onTap: () {
                Navigator.pop(context);
              },
              btnTxt: 'Cancel',
              fontColor: darkBlue,
              color: blue.withOpacity(0.1),
            ),
          ],
        ),
      ),
    );
  }
}