import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/link.dart';

import '../widgets/curvedAppbar.dart';
import '../widgets/titledAppBar.dart';

class AdviceDetailsBullying extends StatefulWidget {
  const AdviceDetailsBullying({Key? key, required this.categry})
      : super(key: key);
  final String categry;
  @override
  State<AdviceDetailsBullying> createState() => _AdviceDetailsBullyingState();
}

class _AdviceDetailsBullyingState extends State<AdviceDetailsBullying>
    with Crud {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitledAppBar(title: 'التعامل مع التنمر الإلكتروني'),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 70.w,
                ),
                child: FutureBuilder(
                  future: advice(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List? snap = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasError) {
                      return SizedBox(
                        height: 220.h,
                        child: ListView.builder(
                          itemCount: snap!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 60.h,
                                  width: 500.w,
                                  child: Card(
                                    color: Color.fromRGBO(237, 236, 242, 1),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Link(
                                          target: LinkTarget.blank,
                                          uri: Uri.parse(
                                              '${snap[index]['refrence_url']}'),
                                          builder: (context, followLink) =>
                                              GestureDetector(
                                                onTap: followLink,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h,
                                                      horizontal: 5.w),
                                                  child: Text(
                                                      ' ${snap[index]['title']}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6),
                                                ),
                                              )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                )
                              ],
                            );
                          },
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  advice() async {
    return await postRequest2(linkAdvice, {'categry': widget.categry});
  }
}
