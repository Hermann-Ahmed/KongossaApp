import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourAccountController extends GetxController {
  TextEditingController emailFieldController = TextEditingController();

  @override
  void dispose() {
    emailFieldController.clear();
    super.dispose();
  }
}