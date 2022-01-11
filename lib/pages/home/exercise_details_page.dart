import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/exercise_model.dart';
import 'package:exercise_app/widgets/custom_circle_button.dart';
import 'package:flutter/material.dart';

class ExerciseDetailsPage extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetailsPage({Key? key, required this.exercise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          exercise.name,
          style: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 50,
        leading: CustomCircleButton(
          onTap: () {
            Navigator.pop(context);
          },
          imagePath: 'back.png',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              Image.asset(
                exercise.imagePath,
                height: 300.0,
                fit: BoxFit.fill,
              ),
              h20,
              for (int i = 0; exercise.steps.length > i; i++)
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            color: white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: blue,
                      ),
                      w20,
                      Container(
                        width: 260,
                        color: white,
                        child: Text(
                          exercise.steps[i],
                          style: TextStyle(
                            color: black.withOpacity(0.6),
                            letterSpacing: 1,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
