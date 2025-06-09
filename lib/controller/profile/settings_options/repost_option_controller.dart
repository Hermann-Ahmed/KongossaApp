import 'package:get/get.dart';

class RepostOptionController extends GetxController {
  RxBool isSwitchRepost = false.obs;

  void toggleRepost() {
    isSwitchRepost.value = !isSwitchRepost.value;
  }
}