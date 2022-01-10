import 'package:exercise_app/Core/color.dart';
import 'package:flutter/material.dart';

class CustomRoundBtn extends StatelessWidget {
  final Function() onTap;
  final String text;
  const CustomRoundBtn({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[blue, darkBlue],
          ),
          boxShadow: [
            BoxShadow(
              color: blue.withOpacity(0.4),
              offset: const Offset(0, 10),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
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
