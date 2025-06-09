// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/home/video_call_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_size.dart';

class GroupVideoCallView extends StatelessWidget {
  GroupVideoCallView({Key? key}) : super(key: key);

  VideoCallController videoCallController = Get.put(VideoCallController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppSize.size2,
                  mainAxisExtent:
                      MediaQuery.of(context).size.height / AppSize.appSize2,
                  mainAxisSpacing: AppSize.appSize0,
                  crossAxisSpacing: AppSize.appSize0,
                ),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: AppSize.size4,
                itemBuilder: (context, index) {
                  return Container(
                    width: AppSize.appSize195,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            videoCallController.videoCallList[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
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
                  top: AppSize.appSize17,
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
      ),
    );
  }
}
