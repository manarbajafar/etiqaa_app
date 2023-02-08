import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/screens/addChildWay.dart';
import 'package:etiqaa/screens/appUse.dart';
import 'package:etiqaa/screens/childrenList.dart';
import 'package:etiqaa/screens/connectWithUs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/titledAppBar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'homepage.dart';

class HelpCenter extends StatefulWidget {
  // const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(title: 'المساعدات'),
      bottomNavigationBar: CurvedNavigationBar(
          // type: BottomNavigationBarType.fixed,
          index: 2,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          color: Color(0xFFF9AF4B),
          items: [
            Icon(
              Icons.tips_and_updates,
              size: 30.w,
            ),
            Icon(
              Icons.home,
              size: 30.w,
            ),
            Icon(
              Icons.settings,
              size: 30.w,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 210.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(AppUse());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'طريقة استخدام التطبيق',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 210.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(AddChildWay());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'طريقة إضافة طفل',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 210.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(ConnectWithUs());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'تواصل معنا',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
