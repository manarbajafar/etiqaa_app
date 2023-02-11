import 'dart:convert';

import 'package:etiqaa/database/crud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/linkApi.dart';
import '../main.dart';
import '../widgets/curvedAppbar.dart';
import '../controllers/addChild_controller.dart';
import '../widgets/titledAppBar.dart';

class addChild extends StatefulWidget {
  //const addChild({ Key? key }) : super(key: key);

  @override
  State<addChild> createState() => _addChildState();
}

class _addChildState extends State<addChild> with Crud {
  late var childName;
  //DateTime birthdate = DateTime.now();
  TextEditingController birthdate = TextEditingController();
  var gender;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  AddChildController controller =
      Get.put(AddChildController(), permanent: true);

  String getGender(String gender) {
    switch (gender) {
      case 'boy':
        return 'ذكر';
      case 'girl':
        return 'أنثى';
      default:
        return '';
    }
  }

  late bool msg = false;

  DateTime? pickedDate;

  addChild() async {
    if (formstate.currentState!.validate()) {
      msg = false;
      var response = await postRequest2(linkAddChild, {
        "child_name": controller.name.text,
        "gender": getGender(controller.gender),
        "date_of_birth": (controller.date.text),
        "parent_id": sharedPref.getString('parent_id'),
      });
      print(response.toString());
      // response = jsonDecode((response.toString()));

      if (response != null && response["status"] == "success") {
        setState(() {
          if (sharedPref.getInt('childrenNum') != null) {
            sharedPref.setInt(
                'childrenNum', sharedPref.getInt('childrenNum')! + 1);
          } else {
            sharedPref.setInt('childrenNum', 1);
          }
        });
        controller.toConfirmation();
        controller.name.clear();
        controller.date.clear();
        controller.gender = '';
        gender = '';
      } else {
        setState(() {
          msg = true;
        });
        print("Add fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void check() {
      var formData = formstate.currentState;
      if (formData!.validate()) {
        //It runs onSaved function.. After the value is checked, it will be stored in the variable
        formData.save();
        print('valid');
      } else {
        print('not valid');
      }
    }

    return Scaffold(
      appBar: TitledAppBar(title: 'إضافة طفل'),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: TextFormField(
                      controller: controller.name,
                      decoration: InputDecoration(
                        labelText: 'اسم الطفل',
                        labelStyle: Theme.of(context).textTheme.headline5,
                      ),
                      validator: (text) {
                        //just a test,, If I want to check the input
                        if (text!.length < 2) {
                          return 'الرجاء ادخال اسم صحيح';
                        }
                        return null;
                      },
                      onSaved: (text) {
                        childName = text;
                      },
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: TextField(
                      readOnly: true,
                      controller: controller.date,
                      decoration: InputDecoration(
                        labelText: 'تاريخ الميلاد',
                        labelStyle: Theme.of(context).textTheme.headline5,
                      ),
                      onTap: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(DateTime.now().year - 16,
                                DateTime.now().month, DateTime.now().day),
                            firstDate: DateTime(DateTime.now().year - 16,
                                DateTime.now().month, DateTime.now().day),
                            lastDate: DateTime(DateTime.now().year - 7,
                                DateTime.now().month, DateTime.now().day));
                        if (pickedDate != null) {
                          setState(() {
                            controller.date.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate!);
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الجنس',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'boy',
                              groupValue: controller.gender,
                              onChanged: (val) {
                                controller.gender = val;

                                setState(() {
                                  controller.gender = val;
                                });
                              },
                            ),
                            Text('ذكر',
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'girl',
                              groupValue: controller.gender,
                              onChanged: (val) {
                                controller.gender = val;
                                setState(() {
                                  controller.gender = val;
                                });
                              },
                            ),
                            Text('أنثى',
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        ),
                      ],
                    ),
                  ),
                  msg == true
                      ? Text(
                          ' هذا الطفل مضاف مسبقا ',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 19.sp,
                            fontFamily: 'FFHekaya',
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 40.h,
                    width: 200.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).buttonColor,
                      ),
                      onPressed: () async {
                        check();
                        await addChild();
                      },
                      child: Text(
                        'إضافة',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
