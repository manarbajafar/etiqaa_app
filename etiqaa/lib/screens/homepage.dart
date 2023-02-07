import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/screens/accountSettings.dart';
import 'package:flutter/material.dart';

import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/linkApi.dart';
import '../main.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/messagesCards.dart';
import '../widgets/noChildren.dart';

import '../widgets/titledAppBar.dart';
import 'advice.dart';
import 'alertHistory.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

int index = 0;

class _HomePageState extends State<HomePage> with Crud {
  @override
  void initState() {
    super.initState();
  }

  Widget get isHasChild {
    if (sharedPref.getInt('childrenNum') == 0) {
      return NoChildren();
    } else {
      return MessagesCards();
    }
  }

  List<Widget> pages = [
    Advice(),
    HomePage(),
    accountSettings(),
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(),
      bottomNavigationBar: CurvedNavigationBar(
          // type: BottomNavigationBarType.fixed,
          index: 1,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          color: Color(0xFFF9AF4B),
          items: [
            Icon(
              Icons.tips_and_updates_outlined,
              size: 30.h,
            ),
            Icon(
              Icons.home,
              size: 30.h,
            ),
            Icon(
              Icons.settings,
              size: 30.h,
            ),
          ],
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  Get.off(() => Advice());
                  break;
                case 1:
                  Get.off(() => HomePage());
                  break;
                case 2:
                  Get.off(() => accountSettings());
                  break;
              }
            });
          }),
      body: isHasChild,
    );
  }
}
