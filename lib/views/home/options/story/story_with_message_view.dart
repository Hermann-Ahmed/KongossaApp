// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/home/story_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';

class StoryWithMessageView extends StatelessWidget {
  StoryWithMessageView({Key? key}) : super(key: key);

  StoryController storyController = Get.put(StoryController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(),
      ),
    );
  }

  //Story with message content
  _body() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImage.storyImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSize.appSize20,
              right: AppSize.appSize20,
              bottom: AppSize.appSize20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize0
                          : AppSize.appSize10,
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize10
                          : AppSize.appSize0,
                    ),
                    padding: EdgeInsets.only(
                        top: AppSize.appSize10,
                        bottom: AppSize.appSize10,
                        right: AppSize.appSize10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.appSize12),
                      color: AppColor.cardBackgroundColor,
                    ),
                    child: TextFormField(
                      controller: storyController.sendMessageController,
                      cursorColor: AppColor.secondaryColor,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontSemiBold,
                        color: AppColor.secondaryColor,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(bottom: AppSize.appSize5),
                        hintText: AppString.sendMessage,
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
                          padding: const EdgeInsets.only(
                            right: AppSize.appSize14,
                            left: AppSize.appSize14,
                          ),
                          child: Image.asset(
                            AppIcon.emoji,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxWidth: AppSize.appSize46,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: AppSize.appSize48,
                  width: AppSize.appSize48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.appSize12),
                    color: AppColor.primaryColor,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppIcon.send,
                      width: AppSize.appSize20,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: AppSize.appSize12,
            left: AppSize.appSize20,
            right: AppSize.appSize20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize0
                          : AppSize.appSize12,
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize12
                          : AppSize.appSize0,
                      top: AppSize.appSize3,
                    ),
                    child: Image.asset(
                      AppImage.storyProfile,
                      width: AppSize.appSize32,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: languageController
                                          .selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize8,
                              left: languageController
                                          .selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize8
                                  : AppSize.appSize0,
                            ),
                            child: const Text(
                              AppString.eleanorPenaID,
                              style: TextStyle(
                                fontSize: AppSize.appSize12,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFont.appFontSemiBold,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                          ),
                          const Text(
                            AppString.day2,
                            style: TextStyle(
                              fontSize: AppSize.appSize12,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.appFontRegular,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        AppString.eleanorPena,
                        style: TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.appSize11),
                child: Image.asset(
                  AppIcon.info,
                  width: AppSize.appSize2,
                  height: AppSize.appSize14,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: AppSize.appSize2,
                decoration: const BoxDecoration(
                  color: AppColor.text1Color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppSize.appSize2),
                    bottomRight: Radius.circular(AppSize.appSize2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: AppSize.appSize2,
                      width: AppSize.appSize150,
                      decoration: const BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppSize.appSize2),
                          bottomRight: Radius.circular(AppSize.appSize2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: AppSize.appSize6,
            ),
            Expanded(
              child: Container(
                height: AppSize.appSize2,
                decoration: const BoxDecoration(
                  color: AppColor.text1Color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.appSize2),
                    bottomLeft: Radius.circular(AppSize.appSize2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
