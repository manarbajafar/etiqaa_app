import 'dart:convert';

import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/main.dart';
import 'package:etiqaa/screens/alertHistory.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/linkApi.dart';
import '../models/child.dart';
import '../models/message.dart';
import 'package:get/get.dart';
import '../screens/addChild.dart';
import '../screens/alertDetails.dart';

class MessagesCards extends StatefulWidget {
  @override
  State<MessagesCards> createState() => _MessagesCardsState();
}

List<Message> messageList = [];
int index = 0;

class _MessagesCardsState extends State<MessagesCards>
    with TickerProviderStateMixin {
  int? childrenNum = sharedPref.getInt('childrenNum');
  void initState() {
    messageList = [];
    setState(() {
      tablist();
    });
    super.initState();
  }

  getGender(String gender) {
    switch (gender) {
      case 'ذكر':
        return Gender.Boy;
      case 'أنثى':
        return Gender.Girl;
      default:
        return '';
    }
  }

  Crud _crud = Crud();

  bool msg = false;
  messages() async {
    messageList = [];
    var response = await _crud.postRequest2(linkWhatsAppMessages, {
      'parent_id': sharedPref.getString('parent_id'),
    });
    if (response != null && response[0]["statues"] == "success") {
      msg = true;
      for (int i = 0; i < response.length; i++) {
        var responseChild = await _crud.postRequest2(linkChild, {
          'child_name': response[i]["child_name"],
          'parent_id': sharedPref.getString('parent_id'),
        });
        if (responseChild != null && responseChild[0]['statues'] == "success") {
          messageList.add(
            Message(
                id: int.parse(response[i]['msg_id'].toString()),
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

  List children = [];
  List tabList = [];
  tablist() async {
    List response = await _crud.getRequest(linkChildrenList);
    for (int i = 0; i < response.length; i++) {
      if (response[i]['parent_id'].toString() ==
          sharedPref.getString('parent_id')) {
        children.add(
          '${response[i]['child_name']}',
        );
      }
    }
    messages();
  }

  childMessage(int index) async {
    List<Message> childList = [];
    List response = await _crud.postRequest2(linkWhatsAppMessages, {
      'parent_id': sharedPref.getString('parent_id'),
      'child_name': children[index],
    });
    if (response != [] && response[0]["statues"] == "success") {
      for (int i = 0; i < response.length; i++) {
        var responseChild = await _crud.postRequest2(linkChild, {
          'child_name': response[i]["child_name"],
          'parent_id': sharedPref.getString('parent_id'),
        });
        if (responseChild != null && responseChild[0]['statues'] == "success") {
          if (response[i]['child_name'] == children[index]) {
            childList.add(
              Message(
                  id: int.parse(response[i]['msg_id'].toString()),
                  childName: responseChild[0]['child_name'],
                  childgender: getGender(responseChild[0]['gender']),
                  message: response[i]['content'],
                  date: response[i]['date_time'].toString(),
                  senderName: response[i]['sender'],
                  isSaved: false),
            );
          }
        } else {
          print('Child fail');
        }
      }
    } else {
      print('Msg fail');
    }
    return childList;
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 1.w,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Color(0xFFF9AF4B),
                      ),
                      controller: _tabController,
                      isScrollable: true,
                      labelPadding: EdgeInsets.symmetric(horizontal: 3.w),
                      tabs: [
                        Tab(
                            child: Text(
                          '   الكل   ',
                          style: Theme.of(context).textTheme.headline5,
                        )),
                        children.length > 0
                            ? Tab(
                                child: Text(
                                '${children[0]}',
                                style: Theme.of(context).textTheme.headline5,
                              ))
                            : Tab(
                                child: Text('',
                                    style: TextStyle(
                                      // Theme.of(context).textTheme.headline5,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.1),
                                    ))),
                        children.length > 1
                            ? Tab(
                                child: Text(
                                '${children[1]}',
                                style: Theme.of(context).textTheme.headline5,
                              ))
                            : Tab(
                                child: Text('',
                                    style: TextStyle(
                                      // Theme.of(context).textTheme.headline5,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.1),
                                    ))),
                        children.length > 2
                            ? Tab(
                                child: Text(
                                '${children[2]}',
                                style: Theme.of(context).textTheme.headline5,
                              ))
                            : Tab(
                                child: Text('',
                                    style: TextStyle(
                                      // Theme.of(context).textTheme.headline5,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.1),
                                    ))),
                      ]),
                ),
              ),
              Container(
                  child: childrenNum! < 3
                      ? InkWell(
                          onTap: () {},
                          child: InkWell(
                            onTap: () {
                              Get.to(addChild());
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.h),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/addChild.png',
                                    height: 40.h,
                                    width: 40.w,
                                  ),
                                  Text('إضافة طفل',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                ],
                              ),
                            ),
                          ),
                        )
                      : null),
            ],
          ),
          msg == false
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                      child: Text(
                    'لايوجد رسائل',
                    style: Theme.of(context).textTheme.headline1,
                  )),
                )
              : Expanded(
                  child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'أحدث الرسائل',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FutureBuilder(
                            future: messages(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              List? snap = snapshot.data;
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                reverse: false,
                                shrinkWrap: true,
                                itemCount: snap!.length,
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
                                            borderRadius:
                                                BorderRadius.circular(40.r),
                                            child: Card(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 45.h,
                                                        color: Color.fromRGBO(
                                                            237, 236, 242, 1),
                                                        child: Row(children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
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
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        2.h),
                                                            child: Text(
                                                              '${snap[index].childName}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline1,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      15.w),
                                                          child: Text(
                                                            'العبارة',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      15.w),
                                                          child: Text(
                                                            snap[index]
                                                                        .message
                                                                        .length >
                                                                    40
                                                                ? snap[index]
                                                                        .message
                                                                        .substring(
                                                                            0,
                                                                            40) +
                                                                    '.....'
                                                                : snap[index]
                                                                    .message,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Get.off(
                                                                AlertDetails(
                                                                  name: snap[
                                                                          index]
                                                                      .childName,
                                                                  date: snap[
                                                                          index]
                                                                      .date,
                                                                  sender: snap[
                                                                          index]
                                                                      .senderName,
                                                                  content: snap[
                                                                          index]
                                                                      .message,
                                                                  gender: (snap[
                                                                          index]
                                                                      .childgender),
                                                                  isSaved: snap[
                                                                          index]
                                                                      .isSaved,
                                                                  id: snap[
                                                                          index]
                                                                      .id,
                                                                ),
                                                              );
                                                            },
                                                            child: Text(
                                                              'المزيد',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15.sp,
                                                                fontFamily:
                                                                    'FFHekaya',
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
                      ],
                    ),
                    Column(children: [
                      children.length < 1
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Center(
                                  child: Text(
                                'لايوجد رسائل',
                                style: Theme.of(context).textTheme.headline1,
                              )),
                            )
                          : Expanded(
                              flex: 1,
                              child: FutureBuilder(
                                future: childMessage(0),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  List? snap = snapshot.data;
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return snap!.isEmpty
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.h),
                                          child: Text(
                                            'لايوجد رسائل',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                        )
                                      : ListView.builder(
                                          reverse: false,
                                          shrinkWrap: true,
                                          itemCount: snap.length,
                                          itemBuilder: ((context, index) {
                                            print(
                                                'snap[index].message.length: ${snap[index].message.length}');
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.w,
                                                      vertical: 10.h),
                                                  child: SizedBox(
                                                    height: 170.h,
                                                    width: 280.w,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.r),
                                                      child: Card(
                                                          color: Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 45.h,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          237,
                                                                          236,
                                                                          242,
                                                                          1),
                                                                  child: Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10.w,
                                                                          ),
                                                                          child: snap[index].childgender == Gender.Boy
                                                                              ? Image.asset('images/boyIcon_c.png')
                                                                              : Image.asset('images/girlIcon_c.png'),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(vertical: 2.h),
                                                                          child:
                                                                              Text(
                                                                            '${snap[index].childName}',
                                                                            style:
                                                                                Theme.of(context).textTheme.headline1,
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            15.w),
                                                                    child: Text(
                                                                      'العبارة',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline1,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            15.w),
                                                                    child: Text(
                                                                      snap[index].message.length > 40
                                                                          ? snap[index].message.substring(0, 40) +
                                                                              '.....'
                                                                          : snap[index]
                                                                              .message,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline5,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10.w),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Get.off(
                                                                          AlertDetails(
                                                                            name:
                                                                                snap[index].childName,
                                                                            date:
                                                                                snap[index].date,
                                                                            sender:
                                                                                snap[index].senderName,
                                                                            content:
                                                                                snap[index].message,
                                                                            gender:
                                                                                (snap[index].childgender),
                                                                            isSaved:
                                                                                snap[index].isSaved,
                                                                            id: snap[index].id,
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'المزيد',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15.sp,
                                                                          fontFamily:
                                                                              'FFHekaya',
                                                                          decoration:
                                                                              TextDecoration.underline,
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
                    Column(
                      children: [
                        children.length < 2
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Center(
                                    child: Text(
                                  'لايوجد رسائل',
                                  style: Theme.of(context).textTheme.headline1,
                                )),
                              )
                            : Expanded(
                                flex: 1,
                                child: FutureBuilder(
                                  future: childMessage(1),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    List? snap = snapshot.data;
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return snap!.isEmpty
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h),
                                            child: Text(
                                              'لايوجد رسائل',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 10.h),
                                                    child: SizedBox(
                                                      height: 170.h,
                                                      width: 280.w,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.r),
                                                        child: Card(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.r),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        45.h,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            237,
                                                                            236,
                                                                            242,
                                                                            1),
                                                                    child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(
                                                                              horizontal: 10.w,
                                                                            ),
                                                                            child: snap[index].childgender == Gender.Boy
                                                                                ? Image.asset('images/boyIcon_c.png')
                                                                                : Image.asset('images/girlIcon_c.png'),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 2.h),
                                                                            child:
                                                                                Text(
                                                                              '${snap[index].childName}',
                                                                              style: Theme.of(context).textTheme.headline1,
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                      child:
                                                                          Text(
                                                                        'العبارة',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                      child:
                                                                          Text(
                                                                        snap[index].message.length > 40
                                                                            ? snap[index].message.substring(0, 40) +
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
                                                                        horizontal:
                                                                            10.w),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.off(
                                                                            AlertDetails(
                                                                              name: snap[index].childName,
                                                                              date: snap[index].date,
                                                                              sender: snap[index].senderName,
                                                                              content: snap[index].message,
                                                                              gender: (snap[index].childgender),
                                                                              isSaved: snap[index].isSaved,
                                                                              id: snap[index].id,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'المزيد',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontFamily:
                                                                                'FFHekaya',
                                                                            decoration:
                                                                                TextDecoration.underline,
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
                      ],
                    ),
                    Column(
                      children: [
                        children.length < 3
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Center(
                                    child: Text(
                                  'لايوجد رسائل',
                                  style: Theme.of(context).textTheme.headline1,
                                )),
                              )
                            : Expanded(
                                flex: 1,
                                child: FutureBuilder(
                                  future: childMessage(2),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    List? snap = snapshot.data;
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return snap!.isEmpty
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.h),
                                            child: Text(
                                              'لايوجد رسائل',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1,
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 10.h),
                                                    child: SizedBox(
                                                      height: 170.h,
                                                      width: 280.w,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40.r),
                                                        child: Card(
                                                            color:
                                                                Color.fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    1),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.r),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        45.h,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            237,
                                                                            236,
                                                                            242,
                                                                            1),
                                                                    child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(
                                                                              horizontal: 10.w,
                                                                            ),
                                                                            child: messageList[index].childgender == Gender.Boy
                                                                                ? Image.asset('images/boyIcon_c.png')
                                                                                : Image.asset('images/girlIcon_c.png'),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 2.h),
                                                                            child:
                                                                                Text(
                                                                              '${snap[index].childName}',
                                                                              style: Theme.of(context).textTheme.headline1,
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                      child:
                                                                          Text(
                                                                        'العبارة',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                      child:
                                                                          Text(
                                                                        snap[index].message.length > 40
                                                                            ? snap[index].message.substring(0, 40) +
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
                                                                        horizontal:
                                                                            10.w),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.off(
                                                                            AlertDetails(
                                                                              name: snap[index].childName,
                                                                              date: snap[index].date,
                                                                              sender: snap[index].senderName,
                                                                              content: snap[index].message,
                                                                              gender: (snap[index].childgender),
                                                                              isSaved: snap[index].isSaved,
                                                                              id: snap[index].id,
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'المزيد',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontFamily:
                                                                                'FFHekaya',
                                                                            decoration:
                                                                                TextDecoration.underline,
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
                      ],
                    ),
                  ],
                ))
        ],
      ),
    );
  }
}
