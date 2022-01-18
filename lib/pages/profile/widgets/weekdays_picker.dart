import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/size/size_config.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/database/app_db.dart';
import 'package:exercise_app/data/model/alarm.dart';
import 'package:exercise_app/widgets/dialog_box_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeekDaysPicker extends StatefulWidget {
  final Function(List) callBack;
  final String weekId;
  final bool? isUpdate;
  const WeekDaysPicker(
      {Key? key, this.isUpdate, required this.callBack, required this.weekId})
      : super(key: key);

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
  List getSelect = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    getSelect = await ExerciseDatabase.instance.readArlam(widget.weekId);
    if (mounted) {}
    for (int k = 0; k < getSelect.length; k++) {
      setState(() {
        selectedItems.add(getSelect[k].week);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4 * SizeConfig.height!),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.5 * SizeConfig.height!),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Days',
              style: TextStyle(
                color: black.withOpacity(0.6),
                letterSpacing: 0.7,
                fontSize: 2.5 * SizeConfig.text!,
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
            SizedBox(
              height: 50 * SizeConfig.height!,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: items.map((item) {
                  bool isSelected = selectedItems.contains(item);
                  return CheckboxListTile(
                    activeColor: blue,
                    checkColor: white,
                    title: Text(
                      item,
                      style: TextStyle(
                        color: black.withOpacity(0.6),
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                }).toList(),
              ),
            ),
            h30,
            DialogBoxButton(
              onTap: () {
                if (widget.isUpdate != true) {
                  widget.callBack(selectedItems);
                } else {
                  ExerciseDatabase.instance.deleteRepeat(widget.weekId);
                  for (int i = 0; i < selectedItems.length; i++) {
                    var insertRepeat = RepateArlam(
                      week: selectedItems[i],
                      weekID: widget.weekId,
                    );
                    ExerciseDatabase.instance.insertRepeat(insertRepeat);
                  }
                }

                Navigator.pop(context);
              },
              btnTxt: 'Continue',
            ),
            DialogBoxButton(
              onTap: () {
                Navigator.pop(context);
              },
              btnTxt: 'Cancel',
              fontColor: white,
              color: red.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  CheckboxListTile customListtile(
      String item, bool isSelected, Function(bool?) onChanged) {
    return CheckboxListTile(
      activeColor: blue,
      checkColor: white,
      title: Text(
        item,
        style: TextStyle(
          color: black.withOpacity(0.6),
          letterSpacing: 0.7,
          fontWeight: FontWeight.w600,
        ),
      ),
      value: isSelected,
      onChanged: onChanged,
    );
  }
}
