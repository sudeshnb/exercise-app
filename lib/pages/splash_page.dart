import 'dart:async';

import 'package:exercise_app/Core/color.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/BottomNavBar', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: const [
              BoxShadow(
                color: blueShadow,
                offset: Offset(0, 5),
                blurRadius: 20.0,
              )
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/Logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
