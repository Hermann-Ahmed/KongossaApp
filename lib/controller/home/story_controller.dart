import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryController extends GetxController {
  TextEditingController sendMessageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    sendMessageController.clear();
    super.dispose();
  }
}