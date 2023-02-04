import 'package:etiqaa/screens/first_sc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/titledAppBar.dart';

class ConfirmDeletion extends StatelessWidget {
  const ConfirmDeletion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitledAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تم حذف حسابك بنجاح',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                height: 40.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonColor,
                  ),
                  onPressed: () {
                    Get.offAll(firstSc());
                  },
                  child: Text(
                    'صفحة البداية',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
