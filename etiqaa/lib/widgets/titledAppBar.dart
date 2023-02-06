import 'package:etiqaa/widgets/curvedAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:etiqaa/screens/first_sc.dart';
import '../main.dart';

class TitledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  TitledAppBar({this.title = ''});
  Size preferredSize = Size.fromHeight(120.h);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          alignment: Alignment(-1.0.h, -0.7.h),
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // sharedPref.clear();
            // Get.offAll(firstSc());
            Navigator.of(context).pop();
          }
          //=>
          ),
      toolbarHeight: 120.h,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: ClipPath(
        clipper: CurvedAppbar(),
        child: Container(
          height: 250.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.h),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
