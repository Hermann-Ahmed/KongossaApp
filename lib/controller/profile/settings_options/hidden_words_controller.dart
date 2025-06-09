import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_string.dart';

class HiddenWordsController extends GetxController {
  TextEditingController enterWordsController = TextEditingController(text: AppString.emailHint);
}