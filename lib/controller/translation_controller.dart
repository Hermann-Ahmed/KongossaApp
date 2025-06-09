import 'dart:ui';
import 'package:get/get.dart';
import 'package:kongossa/config/app_string.dart';

class TranslationController extends GetxController {
  var locale = AppString.enText;

  void changeLocale(String newLocale) {
    locale = newLocale;
    Get.updateLocale(Locale(newLocale));
    update();
  }
}
