import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/linkApi.dart';
import '../models/child.dart';
import '../models/message.dart';
import 'package:get/get.dart';
import '../screens/addChild.dart';
import '../screens/alertDetails.dart';

class MessagesCards extends StatefulWidget {
  //const MessagesCards({super.key});

  @override
  State<MessagesCards> createState() => _MessagesCardsState();
}

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
int index = 0;

List<Child> childrenlist = [
  Child(
    name: 'سارة',
    isActivated: true,
    gender: Gender.Girl,
    birthday: DateTime.utc(2007, 6, 9),
  ),
  Child(
    name: 'عمر',
    isActivated: false,
    gender: Gender.Boy,
    birthday: DateTime.utc(2010, 11, 9),
  ),
  // Child(
  //   name: 'منار',
  //   isActivated: true,
  //   gender: Gender.Girl,
  //   birthday: DateTime.utc(2010, 11, 9),
  // ),
];

class _MessagesCardsState extends State<MessagesCards>
    with TickerProviderStateMixin {
  late int childrenNum;

  void initState() {
    childrenNum = 0;
    childrenList();
    super.initState();
  }

  Crud _crud = Crud();
  late List snap;
  childrenList() async {
    snap = await _crud.getRequest(linkChildrenList);
    for (int i = 0; i < snap.length; i++) {
      if (snap[i]['parent_id'].toString() ==
          sharedPref.getString('parent_id')) {
        childrenNum++;
      }
    }
    sharedPref.setInt('childrenNum', childrenNum);
    print(sharedPref.getInt('childrenNum'));
  }

  @override
  Widget build(BuildContext context) {
    List tabList = [
      Tab(
          child: Text(
        'الكل',
        style: Theme.of(context).textTheme.headline5,
      )),
      Tab(
        child: Text(
          '${childrenlist[0].name}',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      Tab(
        child: Text(
          '${childrenlist[1].name}',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      // Tab(
      //   child: Text(
      //     '${childrenlist[2].name}',
      //     style: Theme.of(context).textTheme.headline5,
      //   ),
      // ),
    ];

    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 5.w,
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
                      labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      tabs: [
                        tabList[0],
                        tabList[1],
                        tabList[2],
                      ]),
                ),
              ),
              Container(
                  child: childrenNum < 3
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
          Expanded(
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
                    child: ListView.builder(
                      reverse: false,
                      shrinkWrap: true,
                      itemCount: 1,
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
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                  ),
                                                  child: messageList[index]
                                                              .childgender ==
                                                          Gender.Boy
                                                      ? Image.asset(
                                                          'images/boyIcon_c.png')
                                                      : Image.asset(
                                                          'images/girlIcon_c.png'),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.h),
                                                  child: Text(
                                                    '${messageList[index].childName}',
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
                                                  '${messageList[index].message}',
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
                                                    Get.off(AlertDetails(
                                                        idList:
                                                            messageList[index]
                                                                .id));
                                                  },
                                                  child: Text(
                                                    'المزيد',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontFamily: 'FFHekaya',
                                                      decoration: TextDecoration
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
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  // Expanded(
                  //   flex: 1,
                  //   child: ListView.builder(
                  //     reverse: false,
                  //     shrinkWrap: true,
                  //     itemCount: 2,
                  //     itemBuilder: ((context, index) {
                  //       return Column(
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 20.w, vertical: 10.h),
                  //             child: SizedBox(
                  //               height: 170.h,
                  //               width: 280.w,
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(40.r),
                  //                 child: Card(
                  //                     color: Color.fromRGBO(255, 255, 255, 1),
                  //                     child: ClipRRect(
                  //                       borderRadius:
                  //                           BorderRadius.circular(40.r),
                  //                       child: Column(
                  //                         children: [
                  //                           Container(
                  //                             height: 45.h,
                  //                             color: Color.fromRGBO(
                  //                                 237, 236, 242, 1),
                  //                             child: Row(children: [
                  //                               Padding(
                  //                                 padding: EdgeInsets.symmetric(
                  //                                   horizontal: 10.w,
                  //                                 ),
                  //                                 child: messageList[index]
                  //                                             .childgender ==
                  //                                         Gender.Boy
                  //                                     ? Image.asset(
                  //                                         'images/boyIcon_c.png')
                  //                                     : Image.asset(
                  //                                         'images/girlIcon_c.png'),
                  //                               ),
                  //                               Padding(
                  //                                 padding: EdgeInsets.symmetric(
                  //                                     vertical: 2.h),
                  //                                 child: Text(
                  //                                   '${messageList[index].childName}',
                  //                                   style: Theme.of(context)
                  //                                       .textTheme
                  //                                       .headline1,
                  //                                 ),
                  //                               )
                  //                             ]),
                  //                           ),
                  //                           Align(
                  //                             alignment: Alignment.topRight,
                  //                             child: Padding(
                  //                               padding: EdgeInsets.symmetric(
                  //                                   horizontal: 15.w),
                  //                               child: Text(
                  //                                 'العبارة',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .headline1,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Align(
                  //                             alignment: Alignment.topRight,
                  //                             child: Padding(
                  //                               padding: EdgeInsets.symmetric(
                  //                                   horizontal: 15.w),
                  //                               child: Text(
                  //                                 '${messageList[index].message}',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .headline5,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Padding(
                  //                             padding: EdgeInsets.symmetric(
                  //                                 horizontal: 15.w),
                  //                             child: Align(
                  //                               alignment: Alignment.topLeft,
                  //                               child: TextButton(
                  //                                 onPressed: () {
                  //                                   Get.off(AlertDetails(
                  //                                       idList:
                  //                                           messageList[index]
                  //                                               .id));
                  //                                 },
                  //                                 child: Text(
                  //                                   'المزيد',
                  //                                   style: TextStyle(
                  //                                     color: Colors.black,
                  //                                     fontSize: 15.sp,
                  //                                     fontFamily: 'FFHekaya',
                  //                                     decoration: TextDecoration
                  //                                         .underline,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     )),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     }),
                  //   ),
                  // ),
                ],
              ),
              Column(
                children: [
                  // Expanded(
                  //   flex: 1,
                  //   child: ListView.builder(
                  //     reverse: false,
                  //     shrinkWrap: true,
                  //     itemCount: 1,
                  //     itemBuilder: ((context, index) {
                  //       return Column(
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 20.w, vertical: 10.h),
                  //             child: SizedBox(
                  //               height: 170.h,
                  //               width: 280.w,
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(40.r),
                  //                 child: Card(
                  //                     color: Color.fromRGBO(255, 255, 255, 1),
                  //                     child: ClipRRect(
                  //                       borderRadius: BorderRadius.circular(20),
                  //                       child: Column(
                  //                         children: [
                  //                           Container(
                  //                             height: 45.h,
                  //                             color: Color.fromRGBO(
                  //                                 237, 236, 242, 1),
                  //                             child: Row(children: [
                  //                               Padding(
                  //                                 padding: EdgeInsets.symmetric(
                  //                                   horizontal: 10.w,
                  //                                 ),
                  //                                 child: messageList[index]
                  //                                             .childgender ==
                  //                                         Gender.Boy
                  //                                     ? Image.asset(
                  //                                         'images/boyIcon_c.png')
                  //                                     : Image.asset(
                  //                                         'images/girlIcon_c.png'),
                  //                               ),
                  //                               Padding(
                  //                                 padding: EdgeInsets.symmetric(
                  //                                     vertical: 2.h),
                  //                                 child: Text(
                  //                                   '${messageList[index].childName}',
                  //                                   style: Theme.of(context)
                  //                                       .textTheme
                  //                                       .headline1,
                  //                                 ),
                  //                               )
                  //                             ]),
                  //                           ),
                  //                           Align(
                  //                             alignment: Alignment.topRight,
                  //                             child: Padding(
                  //                               padding: EdgeInsets.symmetric(
                  //                                   horizontal: 15.w),
                  //                               child: Text(
                  //                                 'العبارة',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .headline1,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Align(
                  //                             alignment: Alignment.topRight,
                  //                             child: Padding(
                  //                               padding: EdgeInsets.symmetric(
                  //                                   horizontal: 15.w),
                  //                               child: Text(
                  //                                 '${messageList[index].message}',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .headline5,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Padding(
                  //                             padding: EdgeInsets.symmetric(
                  //                                 horizontal: 10.w),
                  //                             child: Align(
                  //                               alignment: Alignment.topLeft,
                  //                               child: TextButton(
                  //                                 onPressed: () {
                  //                                   Get.off(AlertDetails(
                  //                                       idList:
                  //                                           messageList[index]
                  //                                               .id));
                  //                                 },
                  //                                 child: Text(
                  //                                   'المزيد',
                  //                                   style: TextStyle(
                  //                                     color: Colors.black,
                  //                                     fontSize: 15.sp,
                  //                                     fontFamily: 'FFHekaya',
                  //                                     decoration: TextDecoration
                  //                                         .underline,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     )),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     }),
                  //   ),
                  // ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
