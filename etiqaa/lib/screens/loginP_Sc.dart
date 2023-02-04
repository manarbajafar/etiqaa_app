import 'package:etiqaa/controllers/loginp_controller.dart';
import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/main.dart';
import 'package:etiqaa/widgets/custom_textForm.dart';
import 'package:etiqaa/widgets/titledAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPSc extends StatefulWidget {
  @override
  State<LoginPSc> createState() => _LoginPSc();
}

class _LoginPSc extends State<LoginPSc> {
  Crud _crud = Crud();

  bool _passwordVisible = false;
  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();

  bool msg = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    LogInControllerImp controller = Get.put(LogInControllerImp());
    int childrenNum = 0;

    @override
    loginp() async {
      if (loginFormKey.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        print("email: ${controller.email.text}");
        print("password : ${controller.password.text}");
        var response = await _crud.postRequest(linklogin, {
          "email": controller.email.text,
          "password": controller.password.text,
        });
        print("response line 39 : ${response.toString()}");
        isLoading = false;
        setState(() {});
        if (response["status"] == "success") {
          sharedPref.setString(
              'parent_id', response['data']['parent_id'].toString());
          var snap = await _crud.getRequest(linkChildrenList);
          if (snap != []) {
            for (int i = 0; i < snap.length; i++) {
              if (snap[i]['parent_id'].toString() ==
                  sharedPref.getString('parent_id')) {
                childrenNum++;
              }
              sharedPref.setInt('childrenNum', childrenNum);
            }
          } else {
            sharedPref.setInt('childrenNum', childrenNum);
          }
          sharedPref.setString('child_device', '');
          controller.toHomePage();
        } else {
          msg = true;
          setState(() {});
          print("LI fail");
        }
      }
    }

    return Scaffold(
      appBar: TitledAppBar(title: 'تسجيل الدخول'),
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 30.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextForm(
                    controllar: controller.email,
                    textInputType: TextInputType.emailAddress,
                    labelText: ' البريد الالكتروني',
                    padding: EdgeInsets.only(bottom: 10.h),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال البريد الالكتروني';
                      }

                      return null;
                    },
                    obscureText: false,
                  ),
                  CustomTextForm(
                    controllar: controller.password,
                    textInputType: TextInputType.text,
                    labelText: ' كلمة المرور',
                    padding: EdgeInsets.only(bottom: 10.h),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال كلمة المرور';
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Align(
                      alignment: FractionalOffset.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          controller.toForgetPass();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: 0, // space between underline and text
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black, // Text colour here
                            width: 1.0, // Underline width
                          ))),
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontFamily: 'FFHekaya',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  msg == true
                      ? Text(
                          '  البريد الالكتروني او كلمة المرور غير صحيح',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 19.sp,
                            fontFamily: 'FFHekaya',
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20.h,
                  ),
                  isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).buttonColor,
                          ),
                        )
                      : SizedBox(
                          height: 40.h,
                          width: 200.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).buttonColor,
                            ),
                            onPressed: () {
                              print(
                                  "sharedPref.getString('parent_id') in line 221 : ${sharedPref.getString('parent_id')}");
                              loginp();
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.h),
                    child: TextButton(
                      onPressed: () {
                        controller.toSignup();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'مستخدم جديد ؟  ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontFamily: 'FFHekaya',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                bottom: 0.0, // space between underline and text
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: Colors.black, // Text colour here
                                width: 1.0, // Underline width
                              ))),
                              child: Text(
                                '  سجل الان ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontFamily: 'FFHekaya',
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
