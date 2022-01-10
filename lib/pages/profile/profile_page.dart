import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/Core/space.dart';
import 'package:exercise_app/widgets/custom_round_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                '0.0',
                () {},
              ),
              settingsTile(
                'Gender',
                'gender',
                '0.0',
                () {},
              ),
              settingsTile(
                'Height',
                'height',
                '0.0',
                () {},
              ),
              settingsTile(
                'Weight',
                'weight',
                '0.0',
                () {},
              ),
              settingsTile(
                'Date of birth',
                'birthday',
                '0.0',
                () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 20.0,
                ),
                child: CustomRoundBtn(
                  onTap: () {},
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
                    Positioned(
                      top: 0,
                      left: 50,
                      child: Text(
                        'BMI(kg/m2)',
                        style: TextStyle(
                          color: black.withOpacity(0.7),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 50,
                      child: Container(
                        width: 2.0,
                        color: black,
                        height: 50.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'BMI(kg/m2)',
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
