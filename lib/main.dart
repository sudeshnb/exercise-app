import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/route.dart';
import 'package:exercise_app/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExerciseApp());
}

class ExerciseApp extends StatelessWidget {
  const ExerciseApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: white,
        fontFamily: 'Gilroy',
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const SplashPage(),
    );
  }
}
