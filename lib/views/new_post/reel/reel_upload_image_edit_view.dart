// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/controller/new_post/reel_edit_image_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';
import '../../../routes/app_routes.dart';

class ReelUploadImageEditView extends StatelessWidget {
  ReelUploadImageEditView({Key? key}) : super(key: key);

  ReelEditImageController reelEditImageController =
      Get.put(ReelEditImageController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  //Reel Upload Image Edit content
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
          },
          child: Image.asset(
            languageController.selectedLanguageIndex.value == AppSize.size2
                ? AppIcon.backRight
                : AppIcon.back,
          ),
        ),
      ),
      leadingWidth: AppSize.appSize44,
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.reelUploadView);
          },
          child: Container(
            height: AppSize.appSize34,
            width: AppSize.appSize64,
            margin: EdgeInsets.only(
              left: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? AppSize.appSize20
                  : AppSize.appSize0,
              right: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? AppSize.appSize0
                  : AppSize.appSize20,
              top: AppSize.appSize8,
            ),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(AppSize.appSize66),
            ),
            child: const Center(
              child: Text(
                AppString.buttonTextNext,
                style: TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFont.appFontSemiBold,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize32,
        top: AppSize.appSize94,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppImage.reelImage,
              width: kIsWeb ? AppSize.appSize195 : AppSize.appSize236,
              height: kIsWeb ? AppSize.appSize250 : AppSize.appSize329,
            ),
          ),
          Column(
            children: [
              Image.asset(
                AppImage.reelRecord,
              ),
              GestureDetector(
                onTap: () {
                  reelEditImageController.openGallery();
                },
                child: Container(
                  height: AppSize.appSize48,
                  margin: const EdgeInsets.only(top: AppSize.appSize67),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(AppSize.appSize66),
                  ),
                  child: const Center(
                    child: Text(
                      AppString.buttonTextAddFromGallery,
                      style: TextStyle(
                        fontSize: AppSize.appSize16,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.appFontSemiBold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
