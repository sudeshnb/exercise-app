import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/pages/profile/widgets/dob_picker.dart';
import 'package:exercise_app/pages/profile/widgets/gender_picker.dart';
import 'package:exercise_app/pages/profile/widgets/height_picker.dart';
import 'package:exercise_app/pages/profile/widgets/name_picker.dart';
import 'package:exercise_app/pages/profile/widgets/weight_picker.dart';
import 'package:exercise_app/widgets/custom_round_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  String userGender = '';
  String userHeight = '';
  String userweight = '';
  String userDob = '';
  String bmiData = '';
  double bmiValue = 0.0;
  double level = 0.0;
  void bmiCalculation(double value) {
    if (value > 0.0 && value <= 18.49) {
      setState(() {
        bmiData = 'Not meet the standard';
        if (value > 15) {
          level = value * 3;
        } else {
          level = 5;
        }
      });
    } else if (value >= 18.50 && value <= 24.9) {
      setState(() {
        bmiData = 'Normal';
        level = value * 3;
      });
    } else if (value >= 25 && value <= 29.9) {
      setState(() {
        bmiData = 'Overweight';
        if (26 > value) {
          level = value * 7.2;
        } else {
          level = value * 8;
        }
      });
    } else if (value >= 30 && value <= 34.9) {
      setState(() {
        bmiData = 'Obesity Degree 1';

        if (31 > value) {
          level = value * 8.1;
        } else {
          level = value * 8.6;
        }
      });
    } else if (value >= 35 && value <= 39.9) {
      setState(() {
        bmiData = 'Obesity Degree 2';
        if (36 > value) {
          level = value * 8.7;
        } else {
          level = value * 9;
        }
      });
    } else if (value >= 40) {
      setState(() {
        bmiData = 'Obesity Degree 3';
        level = 362;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: black.withOpacity(0.7),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              settingsTile(
                'Name',
                'name',
                userName.isNotEmpty ? userName : '0.0',
                () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return NamePicker(
                          name: (p0) {
                            setState(() => userName = p0);
                          },
                        );
                      });
                },
              ),
              settingsTile(
                'Gender',
                'gender',
                userGender.isNotEmpty ? userGender : '0.0',
                () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return GenderPicker(
                          gender: (p0) {
                            setState(() => userGender = p0);
                          },
                        );
                      });
                },
              ),
              settingsTile(
                'Height',
                'height',
                userHeight.isNotEmpty ? '$userHeight cm' : '0.0',
                () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return HeightPicker(
                          height: (p0) {
                            setState(() => userHeight = p0);
                          },
                        );
                      });
                },
              ),
              settingsTile(
                'Weight',
                'weight',
                userweight.isNotEmpty ? '$userweight kg' : '0.0',
                () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return WeightPicker(
                          weight: (p0) {
                            setState(() => userweight = p0);
                          },
                        );
                      });
                },
              ),
              settingsTile(
                'Date of birth',
                'birthday',
                userDob.isNotEmpty ? userDob : '0.0',
                () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return DOBPicker(
                          dob: (p0) {
                            setState(() => userDob = p0);
                          },
                        );
                      });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 20.0,
                ),
                child: CustomRoundBtn(
                  onTap: () {
                    if (userHeight.isNotEmpty || userweight.isNotEmpty) {
                      var values = (double.parse(userweight) /
                              (double.parse(userHeight) *
                                  double.parse(userHeight))) *
                          10000;

                      bmiValue = double.parse(values.toStringAsFixed(1));
                      bmiCalculation(bmiValue);
                    }
                  },
                  text: 'Calculate',
                ),
              ),
              h10,
              Text(
                'BMI(kg/m2)',
                style: TextStyle(
                  color: black.withOpacity(0.7),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              h10,
              SizedBox(
                height: 120.0,
                child: Stack(
                  children: [
                    Container(
                      height: 60.0,
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          colorTag(
                            color: const Color(0xFFB2D1CF),
                            width: 15.0,
                            value: '15',
                          ),
                          w2,
                          colorTag(
                            color: const Color(0xFF4C6C93),
                            width: 30.0,
                            value: '16',
                          ),
                          w2,
                          colorTag(
                            color: const Color(0xFF74DD78),
                            width: 120.0,
                            value: '18.5',
                          ),
                          w2,
                          colorTag(
                            color: const Color(0xFFDCE683),
                            width: 60.0,
                            value: '25',
                          ),
                          w2,
                          colorTag(
                            color: const Color(0xFFFEB447),
                            width: 60.0,
                            value: '30',
                          ),
                          w2,
                          colorTag(
                              color: const Color(0xFFEA4450),
                              width: 60.0,
                              value: '35',
                              value2: '40'),
                        ],
                      ),
                    ),
                    bmiValue != 0.0
                        ? Positioned(
                            top: 0,
                            left: level > 37 ? level - 30 : level,
                            child: Text(
                              bmiValue.toString(),
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Positioned(
                      top: 15,
                      left: bmiValue != 0.0 ? level : 5,
                      child: Container(
                        width: 2.0,
                        color: black,
                        height: 50.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        bmiData,
                        style: TextStyle(
                          color: black.withOpacity(0.7),
                          letterSpacing: 0.3,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(thickness: 2),
              h10,
              Text(
                'Settings',
                style: TextStyle(
                  color: black.withOpacity(0.7),
                  fontSize: 20.0,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              h20,
              reminderButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget reminderButton() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
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
              child: Image.asset(
                'assets/icons/notification.PNG',
                color: white,
                height: 28.0,
              ),
            ),
          ),
          w20,
          Text(
            'Reminder',
            style: TextStyle(
              color: black.withOpacity(0.7),
              fontSize: 20.0,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget colorTag({
    required Color color,
    required double width,
    required String value,
    String? value2,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 40,
            color: color,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: grey,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              value2 != null
                  ? Text(
                      value2,
                      style: const TextStyle(
                        color: grey,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : const SizedBox()
            ],
          )
        ],
      ),
    );
  }

  Container settingsTile(
      String name, String imagePath, String value, Function() onTap) {
    return Container(
      height: 45.0,
      padding: const EdgeInsets.only(right: 20.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: grey.withOpacity(0.03),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/$imagePath.png',
                color: grey,
                height: 25.0,
              ),
              w10,
              Text(
                name,
                style: const TextStyle(
                  color: grey,
                  letterSpacing: 0.2,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          value != '0.0'
              ? GestureDetector(
                  onTap: onTap,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: blue,
                      letterSpacing: 0.3,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: onTap,
                  child: Image.asset(
                    'assets/icons/add.png',
                    color: grey,
                    height: 25.0,
                  ),
                ),
        ],
      ),
    );
  }
}
