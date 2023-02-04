import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/screens/accountSettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/messagesCards.dart';
import '../widgets/noChildren.dart';
import '../widgets/titledAppBar.dart';
import 'advice.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget get isHasChild {
    // print(
    //     "sharedPref.getInt('childrenNum') ${sharedPref.getInt('childrenNum')}");
    // print(
    //     "sharedPref.getString('parent_id'): ${sharedPref.getString('parent_id')}");
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
              //selectedIndex = index;
            });
          }),
      body: isHasChild,
    );
  }
}
