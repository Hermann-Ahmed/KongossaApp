import 'package:get/get.dart';

class CommentsOptionController extends GetxController {
  RxBool isSwitchComment = false.obs;

  void toggleComment() {
    isSwitchComment.value = !isSwitchComment.value;
  }
}