import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/titledAppBar.dart';
import 'loginP_Sc.dart';

class SuccessCASc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: TitledAppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                  child: Text(
                    'تم انشاء حسابك بنجاح',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).buttonColor,
                    ),
                    onPressed: () {
                      Get.to(LoginPSc());
                    },
                    child: Text(
                      ' تسجيل الدخول ',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
