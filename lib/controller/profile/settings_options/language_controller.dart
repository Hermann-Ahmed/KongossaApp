import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/app_string.dart';
import '../../translation_controller.dart';

class LanguageController extends GetxController {
  TextEditingController languageSearchController = TextEditingController();
  RxInt selectedLanguageIndex = RxInt(0);

  TranslationController translationController = Get.put(TranslationController());

  static const String selectedLanguageKey = AppString.selectedLanguage;

  @override
  void onInit() {
    super.onInit();
    loadSelectedLanguage();
  }

  @override
  void onReady() {
    super.onReady();
    saveSelectedLanguage();
  }

  void selectLanguage(int index) {
    selectedLanguageIndex.value = index;
    String selectedLanguageCode = getLanguageCode(index);
    translationController.changeLocale(selectedLanguageCode);
    saveSelectedLanguage();
  }

  String getLanguageCode(int index) {
    switch (index) {
      case 0:
        return AppString.enText;
      case 1:
        return AppString.hiText;
      case 2:
        return AppString.arText;
      case 3:
        return AppString.zhText;
      case 4:
        return AppString.frText;
      case 5:
        return AppString.deText;
      default:
        return AppString.enText;
    }
  }

  void saveSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(selectedLanguageKey, selectedLanguageIndex.value);
  }

  void loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedLanguageIndex = prefs.getInt(selectedLanguageKey);

    if (savedLanguageIndex != null) {
      selectedLanguageIndex.value = savedLanguageIndex;
      translationController.changeLocale(getLanguageCode(savedLanguageIndex));
    }
  }

  RxList<String> languagesList = [
    AppString.english,
    AppString.hindi,
    AppString.arabic,
    AppString.chinese,
    AppString.france,
    AppString.german,
  ].obs;

  @override
  void dispose() {
    super.dispose();
    languageSearchController.clear();
  }
}