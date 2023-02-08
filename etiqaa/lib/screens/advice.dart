import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/screens/accountSettings.dart';
import 'package:etiqaa/screens/adviceDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/titledAppBar.dart';
import 'homepage.dart';

class Advice extends StatelessWidget {
  //const Advice({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(),
      bottomNavigationBar: CurvedNavigationBar(
          // type: BottomNavigationBarType.fixed,
          index: 0,
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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'النصائح',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(AdviceDetailsBullying(
                      categry: 'تنمر',
                    ));
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'تنمر',
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
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(AdviceDetailsBullying(
                      categry: 'تحرش',
                    ));
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'تحرش',
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
