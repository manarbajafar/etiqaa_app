import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/confirmation_Sc.dart';

abstract class SignupController extends GetxController {
  signup();
  toConfirmation();
}

class SignupControllerImp extends SignupController {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;

  //TextEditingController gender= TextEditingController();
  var gender;

  @override
  signup() {}

  void clearSignIn() {
    name.clear();
    email.clear();
    password.clear();
  }

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    gender = 'boy';
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  toConfirmation() {
    Get.to(() => ConfirmationSc(), arguments: {"email": email.text});
  }
}
