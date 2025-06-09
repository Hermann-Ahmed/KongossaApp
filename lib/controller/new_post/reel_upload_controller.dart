import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReelUploadController extends GetxController {
  TextEditingController descriptionController = TextEditingController();

  RxBool isSwitchLike = false.obs;
  RxBool isSwitchComment = false.obs;

  @override
  void dispose() {
    super.dispose();
    descriptionController.clear();
  }

  void toggleLike() {
    isSwitchLike.value = !isSwitchLike.value;
  }

  void toggleComment() {
    isSwitchComment.value = !isSwitchComment.value;
  }
}