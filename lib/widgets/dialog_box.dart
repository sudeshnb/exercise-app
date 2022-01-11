import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/dialog_box_button.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String? subTitle;

  final Function() onContinue;
  const AppDialog({
    Key? key,
    this.title,
    this.subTitle,
    required this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: white,
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
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: TextStyle(
                color: black.withOpacity(0.6),
                letterSpacing: 0.7,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            h20,
            Text(
              subTitle ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black.withOpacity(0.4),
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            h20,
            DialogBoxButton(
              onTap: onContinue,
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
