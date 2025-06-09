import 'package:get/get.dart';

class LikeOptionController extends GetxController {
  RxBool isSwitchLike = false.obs;

  void toggleLike() {
    isSwitchLike.value = !isSwitchLike.value;
  }
}