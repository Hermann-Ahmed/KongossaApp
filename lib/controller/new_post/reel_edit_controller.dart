import 'package:get/get.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/config/app_string.dart';

class ReelEditController extends GetxController {
  RxInt isSelected = 1.obs;

  void selectItem(int index) {
    isSelected.value = index;
  }

  RxList<String> reelEditIcon = [
    AppIcon.trim,
    AppIcon.music,
    AppIcon.filter1,
    AppIcon.filter1,
    AppIcon.magic,
    AppIcon.speed,
    AppIcon.bg,
    AppIcon.recode,
    AppIcon.volume1,
    AppIcon.flip,
    AppIcon.crop,
  ].obs;

  RxList<String> reelEditString = [
    AppString.trim,
    AppString.music,
    AppString.filter,
    AppString.effects,
    AppString.text,
    AppString.speed,
    AppString.bg,
    AppString.recode,
    AppString.volume,
    AppString.flip,
    AppString.crop,
  ].obs;
}
