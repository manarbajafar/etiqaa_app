import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/widgets/welcome2nd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/curvedAppbar.dart';
import '../widgets/titledAppBar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'homepage.dart';

class AddChildWay extends StatefulWidget {
  // const AddChildWay({super.key});

  @override
  State<AddChildWay> createState() => _AddChildWayState();
}

class _AddChildWayState extends State<AddChildWay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(),
      bottomNavigationBar: CurvedNavigationBar(
          // type: BottomNavigationBarType.fixed,
          index: 2,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          color: Color(0xFFF9AF4B),
          items: [
            Icon(
              Icons.tips_and_updates,
              size: 30,
            ),
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.settings,
              size: 30,
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Get.off(Advice());
                break;
              case 1:
                Get.off(HomePage());
                break;
              case 2:
                Get.off(accountSettings());
                break;
            }
            //selectedIndex = index;
          }),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: WelcomeSecond(),
      ),
    );
  }
}
