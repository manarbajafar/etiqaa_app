import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/widgets/messagesCards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';
import '../main.dart';
import '../models/child.dart';
import '../models/message.dart';
import '../widgets/curvedAppbar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'alertDetails.dart';
import 'homepage.dart';

Gender getGender(String gender) {
  switch (gender) {
    case 'ذكر':
      return Gender.Boy;
    case 'أنثى':
      return Gender.Girl;
    default:
      return Gender.Boy;
  }
}

Crud _crud = Crud();

bool msg = false;
List<Message> messageList = [];

messages() async {
  messageList = [];
  List response = await _crud.postRequest2(linkAlertHistory, {
    'parent_id': sharedPref.getString('parent_id'),
  });
  if (response != null && response[0]["statues"] == "success") {
    for (int i = 0; i < response.length; i++) {
      var responseChild = await _crud.postRequest2(linkChild, {
        'child_name': response[i]["child_name"],
        'parent_id': sharedPref.getString('parent_id'),
      });
      print('responceChild: ${responseChild.toString()}');
      if (responseChild != null && responseChild[0]['statues'] == "success") {
        msg = true;
        messageList.add(
          Message(
              id: int.parse(response[i]['msg_id']),
              childName: responseChild[0]['child_name'],
              childgender: getGender(responseChild[0]['gender']),
              message: response[i]['content'],
              date: response[i]['date_time'].toString(),
              senderName: response[i]['sender'],
              isSaved: false),
        );
      } else {
        print('Child fail');
      }
    }
  } else {
    print('Msg fail');
  }
  return messageList;
}

class AlertHistory extends StatefulWidget {
  @override
  State<AlertHistory> createState() => _AlertHistoryState();
}

class _AlertHistoryState extends State<AlertHistory> {
  @override
  void initState() {
    messageList = [];
    super.initState();
  }

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
      body: Center(
        child: Column(children: [
          Text(
            'سجل التنبيهات',
            style: Theme.of(context).textTheme.headline1,
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: messages(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List? snap = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return snap!.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          'لاتوجد رسائل محفوظة',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )
                    : ListView.builder(
                        reverse: false,
                        shrinkWrap: true,
                        itemCount: snap.length,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                child: SizedBox(
                                  height: 170.h,
                                  width: 280.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.r),
                                    child: Card(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 45.h,
                                                color: Color.fromRGBO(
                                                    237, 236, 242, 1),
                                                child: Row(children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                    ),
                                                    child: snap[index]
                                                                .childgender ==
                                                            Gender.Boy
                                                        ? Image.asset(
                                                            'images/boyIcon_c.png')
                                                        : Image.asset(
                                                            'images/girlIcon_c.png'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.h),
                                                    child: Text(
                                                      '${snap[index].childName}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.w),
                                                  child: Text(
                                                    'العبارة',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.w),
                                                  child: Text(
                                                    snap[index].message.length >
                                                            40
                                                        ? snap[index]
                                                                .message
                                                                .substring(
                                                                    0, 40) +
                                                            '.....'
                                                        : snap[index].message,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Get.off(
                                                        AlertDetails(
                                                          name: snap[index]
                                                              .childName,
                                                          date:
                                                              snap[index].date,
                                                          sender: snap[index]
                                                              .senderName,
                                                          content: snap[index]
                                                              .message,
                                                          gender: (snap[index]
                                                              .childgender),
                                                          isSaved: snap[index]
                                                              .isSaved,
                                                          id: snap[index].id,
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'المزيد',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.sp,
                                                        fontFamily: 'FFHekaya',
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
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
                      );
              },
            ),
          )
        ]),
      ),
    );
  }
}
