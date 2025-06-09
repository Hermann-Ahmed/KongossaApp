import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageChatController extends GetxController {
  TextEditingController typeMessageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  @override
  void onClose() {
    messageFocusNode.dispose();
    super.onClose();
  }
}