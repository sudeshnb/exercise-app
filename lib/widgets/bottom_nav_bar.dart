import 'package:exercise_app/Core/color.dart';
import 'package:exercise_app/data/nav_button_data.dart';
import 'package:exercise_app/pages/home/home_page.dart';
import 'package:exercise_app/pages/profile/profile_page.dart';
import 'package:exercise_app/pages/report/report_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController controller = PageController();
  int selectBtn = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        onPageChanged: (value) => setState(() {
          selectBtn = value;
        }),
        itemCount: bottomMenu.length,
        itemBuilder: (itemBuilder, index) {
          return Container(
            child: bottomMenu[index],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0,
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: blue.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; navButtons.length > i; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      controller.jumpToPage(i);
                      selectBtn = i;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        selectBtn == i
                            ? navButtons[i].selectImage
                            : navButtons[i].unselectImage,
                        height: 28.0,
                        color: selectBtn == i ? blue : darkGrey,
                      ),
                      Text(
                        navButtons[i].name,
                        style: TextStyle(
                          color: selectBtn == i ? lightBlue : darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> bottomMenu = [
  const HomePage(),
  const ReportsPage(),
  const ProfilePage(),
];
