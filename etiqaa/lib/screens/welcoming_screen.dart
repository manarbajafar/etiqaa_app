import 'package:etiqaa/screens/addChild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/titledAppBar.dart';
import '../widgets/welcome1st.dart';
import '../widgets/welcome2nd.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'childrenList.dart';
import 'homepage.dart';

class Welcoming extends StatelessWidget {
  final _controller = PageController();

  //Welcoming({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitledAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'مرحبا بك',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 300.h,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.h),
                  child: PageView(
                    controller: _controller,
                    children: [
                      WelcomeFirst(),
                      WelcomeSecond(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 2,
                  effect: const SwapEffect(activeDotColor: Color(0xF0F9AF4B)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: SizedBox(
                  height: 40.h,
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // ignore: deprecated_member_use
                      primary: const Color(0xF0F9AF4B),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => HomePage()),
                        ),
                      );
                    },
                    child: Text(
                      'التالي',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
