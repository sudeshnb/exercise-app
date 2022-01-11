import 'package:exercise_app/Core/color.dart';
import 'package:flutter/material.dart';

class DialogBoxButton extends StatelessWidget {
  final Function() onTap;
  final String btnTxt;
  final Color? color;
  final Color? fontColor;
  const DialogBoxButton({
    Key? key,
    required this.onTap,
    required this.btnTxt,
    this.color,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.0,
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[color ?? blue, color ?? darkBlue],
          ),
          boxShadow: [
            BoxShadow(
              color: blue.withOpacity(0.3),
              offset: const Offset(0, 10),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            btnTxt,
            style: const TextStyle(
              color: white,
              fontSize: 21.0,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
