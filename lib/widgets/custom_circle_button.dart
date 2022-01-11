import 'package:exercise_app/Core/color.dart';
import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final String imagePath;
  final Function() onTap;
  const CustomCircleButton(
      {Key? key, required this.onTap, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.0,
        width: 45.0,
        margin: const EdgeInsets.only(top: 5.0, left: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: blue.withOpacity(0.2),
              offset: const Offset(1, 1),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            'assets/icons/$imagePath',
            color: darkBlue,
          ),
        ),
      ),
    );
  }
}
