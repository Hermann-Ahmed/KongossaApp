import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  TextEditingController commentsFieldController = TextEditingController();

  @override
  void dispose() {
    commentsFieldController.clear();
    super.dispose();
  }
}