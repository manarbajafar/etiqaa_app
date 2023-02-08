import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/titledAppBar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'homepage.dart';

class ConnectWithUs extends StatefulWidget {
  const ConnectWithUs({Key? key}) : super(key: key);
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData twitter =
      IconData(0xf309, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  State<ConnectWithUs> createState() => _ConnectWithUsState();
}

class _ConnectWithUsState extends State<ConnectWithUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(title: 'تواصل معنا'),
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
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: 300.w,
                  child: Card(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                      ),
                      onPressed: () {
                        lanchEmail();
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        title: Center(
                          child: Text(
                            'EtiqaaApp@gmail.com',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: 300.w,
                    child: Card(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                        ),
                        onPressed: () {
                          lanchTwitter();
                        },
                        child: ListTile(
                          leading: Image.asset(
                            'images/twitter.png',
                            height: 25.h,
                            width: 25.w,
                          ),
                          title: Center(
                            child: Text(
                              '@EtiqaaApp',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

lanchEmail() async {
  final url = 'mailto:EtiqaaApp@gmail.com?sublect=' '';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Send fail');
  }
}

lanchTwitter() async {
  final url = 'https://twitter.com/EtiqaaApp';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Send fail');
  }
}
