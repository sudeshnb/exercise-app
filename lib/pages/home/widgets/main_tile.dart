import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/level_model.dart';
import 'package:flutter/material.dart';

class MainExerciseTile extends StatelessWidget {
  final Levels level;
  const MainExerciseTile({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
          right: 30.0,
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: blue.withOpacity(0.2),
              offset: const Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: AssetImage(level.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            h10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                level.title,
                style: const TextStyle(
                  color: black,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            h5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "${level.time} min - ${level.kcal} kcal",
                style: const TextStyle(
                  color: grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
