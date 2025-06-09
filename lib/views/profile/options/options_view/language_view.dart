// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/controller/translation_controller.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_font.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_size.dart';

class LanguageView extends StatelessWidget {
  LanguageView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());
  TranslationController translationController =
      Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  //Language content
  _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      scrolledUnderElevation: AppSize.appSize0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(
            top: AppSize.appSize12, left: AppSize.appSize6),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: AppSize.appSize12,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize13
                    : AppSize.appSize0,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppIcon.backRight
                      : AppIcon.back,
                  width: AppSize.appSize24,
                ),
              ),
            ),
            Text(
              AppString.languageT.tr,
              style: const TextStyle(
                fontSize: AppSize.appSize20,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.appSize24,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        children: [
          Container(
            height: AppSize.appSize48,
            padding: const EdgeInsets.only(
              left: AppSize.appSize14,
              right: AppSize.appSize14,
            ),
            decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
              border: Border.all(
                  color: AppColor.borderColor, width: AppSize.appSizePoint7),
            ),
            child: Center(
              child: TextFormField(
                controller: languageController.languageSearchController,
                cursorColor: AppColor.secondaryColor,
                style: const TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontSemiBold,
                  color: AppColor.secondaryColor,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: AppString.searchT.tr,
                  hintStyle: const TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.text1Color,
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize8
                          : AppSize.appSize0,
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize0
                          : AppSize.appSize8,
                    ),
                    child: Image.asset(AppIcon.searchLike),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxWidth: AppSize.appSize26,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languageController.languagesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    languageController.selectLanguage(index);
                  },
                  child: Obx(() => Container(
                        height: AppSize.appSize48,
                        padding: const EdgeInsets.only(
                          left: AppSize.appSize14,
                          right: AppSize.appSize14,
                        ),
                        margin: const EdgeInsets.only(bottom: AppSize.appSize8),
                        decoration: BoxDecoration(
                          color:
                              languageController.selectedLanguageIndex.value ==
                                      index
                                  ? AppColor.cardBackgroundColor
                                  : AppColor.transparentColor,
                          borderRadius:
                              BorderRadius.circular(AppSize.appSize12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              languageController.languagesList[index],
                              style: const TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                            Image.asset(
                              languageController.selectedLanguageIndex.value ==
                                      index
                                  ? AppIcon.fillRadio
                                  : AppIcon.emptyRadio,
                              width: AppSize.appSize18,
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
