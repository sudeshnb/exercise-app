import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/data/level_model.dart';
import 'package:flutter/material.dart';

class ExtraExerciseTile extends StatelessWidget {
  final Levels level;
  const ExtraExerciseTile({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/ViewAllExercisePage',
          arguments: level,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(level.imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: blueShadow.withOpacity(0.5),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: 130.0,
              width: 200.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Text(
                  level.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: white,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
