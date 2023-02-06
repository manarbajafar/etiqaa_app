import 'dart:convert';

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
import '../widgets/titledAppBar.dart';
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

class AlertHistory extends StatefulWidget {
  @override
  State<AlertHistory> createState() => _AlertHistoryState();
}

class _AlertHistoryState extends State<AlertHistory> {
  @override
  void initState() {
    setState(() {
      messageList = [];
    });
    super.initState();
  }

  messages() async {
    messageList.clear();
    var response = await _crud.postRequest2(linkAlertHistory, {
      'parent_id': sharedPref.getString('parent_id'),
    });
    // print('response line 40: ${response.toString()}');
    if (response != null && response[0]["statues"] == "success") {
      for (int i = 0; i < response.length; i++) {
        var responseChild = await _crud.postRequest2(linkChild, {
          'child_name': response[i]["child_name"],
          'parent_id': sharedPref.getString('parent_id'),
        });
        // print('responceChild: ${responseChild.toString()}');
        if (responseChild != null && responseChild[0]['statues'] == "success") {
          // print('id : ${response[i]['msg_id']}');
          msg = true;
          messageList.add(
            Message(
                id: (response[i]['msg_id']),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(title: 'سجل التنبيهات'),
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
        child: Column(children: [
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
                                  height: 180.h,
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
                                                    replaceLine(snap[index]
                                                                    .message)
                                                                .length >
                                                            25
                                                        ? replaceLine(snap[
                                                                        index]
                                                                    .message)
                                                                .substring(
                                                                    0, 25) +
                                                            '.....'
                                                        : replaceLine(
                                                            snap[index]
                                                                .message),
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
                                                          isSaved: true,
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

  replaceLine(String msg) {
    const splitter = LineSplitter();
    final msgSplit = splitter.convert(msg);
    msg = ' ';
    for (var i = 0; i < msgSplit.length; i++) {
      msg = msg + ' ${msgSplit[i]}';
    }
    return msg;
  }
}
