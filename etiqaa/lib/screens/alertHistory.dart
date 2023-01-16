import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/child.dart';
import '../models/message.dart';
import '../widgets/curvedAppbar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'homepage.dart';

class AlertHistory extends StatelessWidget {
  int data = 1;
  List<Message> messageList = [
    Message(
        id: 1,
        childName: 'سارة',
        childgender: Gender.Girl,
        message: 'غبية وقذرة',
        date: '2022-10-07 10:30',
        senderName: 'ريم محمد'),
    Message(
        id: 2,
        childName: 'سارة',
        childgender: Gender.Girl,
        message: 'لاتقول لامك',
        date: '2022-10-06 10:00',
        senderName: 'ريم محمد'),
    Message(
        id: 3,
        childName: 'عمر',
        childgender: Gender.Boy,
        message: 'اطعنك',
        date: '2022-10-06 10:00',
        senderName: 'ريم محمد'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment(-1.0.h, -0.7.h),
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
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
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Image.asset(
                    'images/whiteLogo.png',
                    height: 70.h,
                    width: 70.w,
                  ),
                ),
              ),
            )),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          // type: BottomNavigationBarType.fixed,
          index: 2,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          color: Color(0xFFF9AF4B),
          items: [
            Icon(
              Icons.tips_and_updates_outlined,
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
                Get.to(Advice());
                break;
              case 1:
                Get.to(HomePage());
                break;
              case 2:
                Get.to(accountSettings());
                break;
            }
            //selectedIndex = index;
          }),
      body: Column(children: [
        Text(
          'سجل التنبيهات',
          style: Theme.of(context).textTheme.headline1,
        ),
        Expanded(
          flex: 1,
          child: ListView.builder(
            reverse: false,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 210,
                      width: 350,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Card(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    color: Color.fromRGBO(237, 236, 242, 1),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: messageList[data].childgender ==
                                                Gender.Boy
                                            ? Image.asset(
                                                'images/boyIcon_c.png')
                                            : Image.asset(
                                                'images/girlIcon_c.png'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${messageList[data].childName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200.0),
                                    child: Text(
                                      'العبارة',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 200.0),
                                    child: Text(
                                      '${messageList[data].message}',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ]),
    );
  }
}
