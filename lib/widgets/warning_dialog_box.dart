import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/dialog_box_button.dart';
import 'package:flutter/material.dart';

class WarningDialogBox extends StatelessWidget {
  final String title;

  const WarningDialogBox({
    Key? key,
    required this.title,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/warning_shield.png',
                  color: Colors.orange.withOpacity(0.7),
                  height: 30.0,
                ),
                w10,
                Text(
                  'Warning',
                  style: TextStyle(
                    color: black.withOpacity(0.6),
                    letterSpacing: 0.7,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            h20,
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black.withOpacity(0.4),
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            h20,
            DialogBoxButton(
              onTap: () => Navigator.pop(context),
              btnTxt: 'OK',
            ),
          ],
        ),
      ),
    );
  }
}
