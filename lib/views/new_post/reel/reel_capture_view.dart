// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_image.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class ReelCaptureView extends StatelessWidget {
  ReelCaptureView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(context),
      ),
    );
  }

  //Reel Capture content
  _body(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: AppColor.backgroundColor,
                child: Image.asset(
                  AppImage.reelVideoImage,
                  fit: BoxFit.cover,
                ),
                // Chewie(
                //   controller: reelCaptureController.chewieController!,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSize.appSize20,
                  top: AppSize.appSize18,
                  right: AppSize.appSize20,
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
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSize.appSize20,
                  right: AppSize.appSize20,
                  bottom: AppSize.appSize38,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.reelEditView);
                        },
                        child: Container(
                          height: AppSize.appSize34,
                          width: AppSize.appSize64,
                          decoration: BoxDecoration(
                            color: AppColor.text1Color,
                            borderRadius:
                                BorderRadius.circular(AppSize.appSize66),
                          ),
                          child: const Center(
                            child: Text(
                              AppString.buttonTextEdit,
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
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.reelUploadView);
                        },
                        child: Container(
                          height: AppSize.appSize34,
                          width: AppSize.appSize64,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius:
                                BorderRadius.circular(AppSize.appSize66),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
