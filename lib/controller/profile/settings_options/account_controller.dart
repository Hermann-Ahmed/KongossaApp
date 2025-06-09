import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_string.dart';

class AccountController extends GetxController {
  TextEditingController emailController =
      TextEditingController(text: AppString.emailHint);
  TextEditingController phoneNumberController =
      TextEditingController(text: AppString.phoneHint);
  TextEditingController dateOfBirthController =
      TextEditingController(text: AppString.dobHint);

  @override
  void dispose() {
    emailController.clear();
    phoneNumberController.clear();
    dateOfBirthController.clear();
    super.dispose();
  }
}
