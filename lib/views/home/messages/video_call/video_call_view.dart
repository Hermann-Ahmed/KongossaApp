// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

import '../../../../config/app_color.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_size.dart';

class VideoCallView extends StatelessWidget {
  VideoCallView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.groupVideoCallView);
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.videoCall2),
                  fit: BoxFit.cover,
                ),
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
            Positioned(
              right: AppSize.appSize20,
              bottom: AppSize.appSize124,
              child: Image.asset(
                AppImage.miniVideo1,
                height: AppSize.appSize182,
                width: AppSize.appSize132,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: AppSize.appSize20),
                height: AppSize.appSize114,
                width: AppSize.appSize34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.appSize65),
                  color: AppColor.backgroundColor
                      .withOpacity(AppSize.appSizePoint5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppIcon.magic,
                      width: AppSize.appSize18,
                    ),
                    Image.asset(
                      AppIcon.frame,
                      width: AppSize.appSize18,
                    ),
                    Image.asset(
                      AppIcon.filter,
                      width: AppSize.appSize18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
