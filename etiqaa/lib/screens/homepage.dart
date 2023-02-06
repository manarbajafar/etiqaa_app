import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/screens/accountSettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/linkApi.dart';
import '../main.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/messagesCards.dart';
import '../widgets/noChildren.dart';
import '../widgets/notificationApi.dart';
import '../widgets/titledAppBar.dart';
import 'advice.dart';
import 'alertHistory.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

late final NotificationApi notification = NotificationApi();

class _HomePageState extends State<HomePage> with Crud {
  notify() async {
    var response = await postRequest2(linkNotification, {
      'parent_id': '${await sharedPref.getString('parent_id')}',
    });
    print('line 29 response: ${response.toString()}');
    print('line 30 parent_id: ${sharedPref.getString('parent_id')}');
    if (response[0]['statues'] == 'success') {
      NotificationApi().showNotification(
          id: 0,
          title: 'اتقاء',
          body: 'اكتشفنا مشكلة محتملة',
          payload: 'payload');

      for (int i = 0; i < response.length; i++) {
        var response2 = await postRequest2(linkSendedMessage, {
          'msg_id': response[i]['msg_id'].toString(),
          'parent_id': sharedPref.getString('parent_id'),
          'child_name': response[i]['child_name'],
        });
      }
    }
  }

  Widget get isHasChild {
    notification.initNotification();
    listenNotification();
    // print(
    //     "sharedPref.getInt('childrenNum') ${sharedPref.getInt('childrenNum')}");
    // print(
    //     "sharedPref.getString('parent_id'): ${sharedPref.getString('parent_id')}");
    if (sharedPref.getInt('childrenNum') == 0) {
      return NoChildren();
    } else {
      listenNotification();
      notify();
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

  void listenNotification() =>
      NotificationApi.onNotificatonClick.stream.listen(onNotificationListener);

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload: $payload');

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AlertHistory(),
      ));
      // Get.to(AlertHistory());
      // Get.off(
      //   AlertDetails(
      //       name: 'meme',
      //       date: '12',
      //       sender: 'haya',
      //       content: 'hello hello',
      //       gender: Gender.Boy,
      //       isSaved: true,
      //       id: 1),
      // );
    }
  }
}
