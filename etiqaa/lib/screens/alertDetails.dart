import 'package:etiqaa/screens/alertHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/child.dart';
import '../models/message.dart';
import 'homepage.dart';

class AlertDetails extends StatelessWidget {
  final int idList;
  const AlertDetails({
    Key? key,
    required this.idList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 270.h,
            child: Container(
              color: const Color.fromRGBO(236, 235, 241, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 10.w,
                        color: Colors.black,
                        onPressed: () {
                          Get.offAll(HomePage());
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        messageList[idList].childgender == Gender.Boy
                            ? Image.asset('images/boyIcon_c.png')
                            : Image.asset('images/girlIcon_c.png'),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Text(
                            '${messageList[idList].childName}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      'الوقت',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      '${messageList[idList].date}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      'المرسل',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      '${messageList[idList].senderName}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      'العبارة',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(
                      '${messageList[idList].message}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Center(
                    child: Text(
                      'هل تريد حفظ الرسالة؟',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40.h,
                        width: 100.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // ignore: deprecated_member_use
                            primary: const Color(0xF0F9AF4B),
                          ),
                          onPressed: () {
                            Get.to(AlertHistory(), arguments: [1]);
                          },
                          child: Text(
                            'نعم',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                        width: 100.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // ignore: deprecated_member_use
                            primary: const Color(0xF0F9AF4B),
                          ),
                          onPressed: () {
                            SetState() {
                              isVisible = !isVisible;
                            }

                            Get.off(HomePage());
                          },
                          child: Text(
                            'لا',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
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
