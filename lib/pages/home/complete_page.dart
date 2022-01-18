import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/size/size_config.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/data/level_model.dart';
import 'package:exercise_app/widgets/custom_circle_button.dart';
import 'package:exercise_app/widgets/custom_round_btn.dart';
import 'package:flutter/material.dart';

class CompletePage extends StatelessWidget {
  final Levels level;
  const CompletePage({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            height: height / 2.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(level.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomCircleButton(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/ViewAllExercisePage',
                (route) => false,
                arguments: level,
              );
            },
            imagePath: 'back.png',
          ),
          Container(
            height: height,
            width: double.infinity,
            margin: EdgeInsets.only(top: height / 3.2),
            padding: EdgeInsets.symmetric(
              vertical: 2.5 * SizeConfig.height!,
              horizontal: 2.5 * SizeConfig.height!,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5 * SizeConfig.height!),
                topRight: Radius.circular(5 * SizeConfig.height!),
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Well Done, You\'ve completed this workout!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 3 * SizeConfig.text!,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                h10,
                Image.asset('assets/icons/trophy.PNG',
                    height: 23 * SizeConfig.height!),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 3.5 * SizeConfig.height!,
                          backgroundColor: blue,
                          child: Text(
                            level.kcal,
                            style: TextStyle(
                              color: white,
                              fontSize: 2.5 * SizeConfig.text!,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        h10,
                        Text(
                          'Calories Burned',
                          style: TextStyle(
                            color: black,
                            fontSize: 2.2 * SizeConfig.text!,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    w30,
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 3.5 * SizeConfig.height!,
                          backgroundColor: blue,
                          child: Text(
                            level.time,
                            style: TextStyle(
                              color: white,
                              fontSize: 2.5 * SizeConfig.text!,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        h10,
                        Text(
                          'Minutes',
                          style: TextStyle(
                            color: black,
                            fontSize: 2.2 * SizeConfig.text!,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                h30,
                CustomRoundBtn(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/BottomNavBar',
                        (route) => false,
                      );
                    },
                    text: 'Complete'),
                h10,
              ],
            ),
          )
        ]),
      ),
    );
  }
}
