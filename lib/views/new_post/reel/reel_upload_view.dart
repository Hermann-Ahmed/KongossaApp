// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/new_post/reel_upload_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';
import '../../../config/app_color.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';

class ReelUploadView extends StatelessWidget {
  ReelUploadView({Key? key}) : super(key: key);

  ReelUploadController reelUploadController = Get.put(ReelUploadController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomBar(context),
    );
  }

  //Reel Upload content
  _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize0
              : AppSize.appSize20,
          right: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize20
              : AppSize.appSize0,
          top: AppSize.appSize12,
        ),
        child: GestureDetector(
          onTap: () {
            Get.back();
            reelUploadController.descriptionController.clear();
          },
          child: Image.asset(
            languageController.selectedLanguageIndex.value == AppSize.size2
                ? AppIcon.backRight
                : AppIcon.back,
          ),
        ),
      ),
      leadingWidth: AppSize.appSize44,
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.appSize24,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize12,
      ),
      child: Column(
        children: [
          Container(
            height: AppSize.appSize122,
            padding: const EdgeInsets.all(AppSize.appSize12),
            decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize14
                        : AppSize.appSize0,
                    right: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize0
                        : AppSize.appSize14,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.reelUploadImageEditView);
                    },
                    child: Image.asset(
                      AppImage.descriptionImage,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: reelUploadController.descriptionController,
                    cursorColor: AppColor.secondaryColor,
                    maxLines: AppSize.size5,
                    maxLength: AppSize.size200,
                    style: const TextStyle(
                      fontSize: AppSize.appSize14,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.appFontRegular,
                      color: AppColor.secondaryColor,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: AppString.addDescription,
                      hintStyle: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text1Color,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    buildCounter: (BuildContext context,
                        {required int currentLength,
                        required bool isFocused,
                        int? maxLength}) {
                      return Text(
                        '$currentLength/$maxLength',
                        style: const TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text1Color,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: AppSize.appSize122,
            margin: const EdgeInsets.only(top: AppSize.appSize11),
            padding: const EdgeInsets.all(AppSize.appSize12),
            decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppString.addLocation,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.secondaryColor,
                  ),
                ),
                Divider(
                  color: AppColor.borderColor,
                  height: AppSize.appSize0,
                ),
                Text(
                  AppString.tagPerson,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.secondaryColor,
                  ),
                ),
                Divider(
                  color: AppColor.borderColor,
                  height: AppSize.appSize0,
                ),
                Text(
                  AppString.addMusic,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: AppSize.appSize82,
            margin: const EdgeInsets.only(top: AppSize.appSize11),
            padding: const EdgeInsets.all(AppSize.appSize12),
            decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppString.hideLike,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        reelUploadController.toggleLike();
                      },
                      child: Obx(() => Image.asset(
                            reelUploadController.isSwitchLike.value
                                ? AppIcon.switchOn
                                : AppIcon.switchOff,
                            width: AppSize.appSize28,
                            height: AppSize.appSize16,
                          )),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColor.borderColor,
                  height: AppSize.appSize0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppString.hideComments,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        reelUploadController.toggleComment();
                      },
                      child: Obx(() => Image.asset(
                            reelUploadController.isSwitchComment.value
                                ? AppIcon.switchOn
                                : AppIcon.switchOff,
                            width: AppSize.appSize28,
                            height: AppSize.appSize16,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _bottomBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GestureDetector(
        onTap: () {
          Get.offAllNamed(AppRoutes.bottomBarView);
        },
        child: Container(
          height: AppSize.appSize48,
          margin: const EdgeInsets.only(bottom: AppSize.appSize32),
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(AppSize.appSize66),
          ),
          child: const Center(
            child: Text(
              AppString.buttonTextUploadNow,
              style: TextStyle(
                fontSize: AppSize.appSize16,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
