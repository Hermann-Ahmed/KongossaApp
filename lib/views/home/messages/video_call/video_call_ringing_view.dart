// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

import '../../../../config/app_color.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_size.dart';

class VideoCallRingingView extends StatelessWidget {
  VideoCallRingingView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.videoCallView);
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.videoCall1),
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
                              ? AppImage.videoOffRight
                              : AppImage.videoOff,
                          width: AppSize.appSize84,
                        ),
                        const SizedBox(
                          width: AppSize.appSize39,
                        ),
                        Image.asset(
                          languageController.selectedLanguageIndex.value ==
                                  AppSize.size2
                              ? AppImage.voiceRecordRight
                              : AppImage.voiceRecord,
                          width: AppSize.appSize84,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
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
          ],
        ),
      ),
    );
  }
}
