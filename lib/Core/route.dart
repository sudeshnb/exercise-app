import 'package:exercise_app/data/level_model.dart';
import 'package:exercise_app/pages/home/home_page.dart';
import 'package:exercise_app/pages/home/view_all_exercise.dart';
import 'package:exercise_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    final arguments = settings?.arguments;
    switch (settings?.name) {
      case '/BottomNavBar':
        return createRoute(child: const BottomNavBar());

      case '/HomePage':
        return createRoute(child: const HomePage());

      case '/ViewAllExercisePage':
        Levels level = arguments as Levels;
        return createRoute(
          child: ViewAllExercise(
            level: level,
          ),
        );

      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

Route createRoute({required Widget child}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
