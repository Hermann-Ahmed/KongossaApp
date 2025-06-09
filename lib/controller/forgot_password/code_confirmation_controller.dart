import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeConfirmationController extends GetxController {
  TextEditingController confirmationCodeController = TextEditingController();

  @override
  void dispose() {
    confirmationCodeController.clear();
    super.dispose();
  }
}