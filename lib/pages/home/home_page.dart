import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/level_model.dart';
import 'package:exercise_app/pages/home/widgets/main_tile.dart';
import 'package:exercise_app/pages/home/widgets/second_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Container(
            height: 100.0,
            padding: const EdgeInsets.only(
              top: 20.0,
              right: 15.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.1,
                    color: black.withOpacity(0.8),
                  ),
                ),
                Text(
                  "Don't Miss the Fitness!",
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.1,
                    color: black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exercise',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: black.withOpacity(0.8),
                ),
              ),
              h30,
              SizedBox(
                height: 300.0,
                child: ListView.builder(
                    itemCount: levels.length - 1,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (itemBuilder, index) {
                      return MainExerciseTile(
                        level: levels[index],
                      );
                    }),
              ),
              h20,
              Text(
                'Extra Exercise',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: black.withOpacity(0.8),
                ),
              ),
              h30,
              ExtraExerciseTile(
                level: levels[levels.length - 1],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
