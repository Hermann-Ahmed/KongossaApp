// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_font.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_size.dart';
import '../../../../config/app_string.dart';

class CallRingingView extends StatelessWidget {
  CallRingingView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.duoCallView);
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.callBlurImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.appSize124),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AppImage.callProfile1,
                      width: AppSize.appSize100,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: AppSize.appSize24),
                    child: Text(
                      AppString.callingTime,
                      style: TextStyle(
                        fontSize: AppSize.appSize16,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.appFontSemiBold,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                  const Text(
                    AppString.eleanorPena,
                    style: TextStyle(
                      fontSize: AppSize.appSize20,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFont.appFontSemiBold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: AppSize.appSize52,
                margin: const EdgeInsets.only(bottom: AppSize.appSize42),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          languageController.selectedLanguageIndex.value ==
                                  AppSize.size2
                              ? AppImage.callFun1Right
                              : AppImage.callFun1,
                          width: AppSize.appSize132,
                        ),
                        const SizedBox(
                          width: AppSize.appSize39,
                        ),
                        Image.asset(
                          languageController.selectedLanguageIndex.value ==
                                  AppSize.size2
                              ? AppImage.callFun2Right
                              : AppImage.callFun2,
                          width: AppSize.appSize132,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Image.asset(
                        AppIcon.callButton,
                        width: AppSize.appSize52,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: AppSize.appSize43,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize20,
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize20
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
          ],
        ),
      ),
    );
  }
}
