// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_size.dart';

class MultipleCallView extends StatelessWidget {
  MultipleCallView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize20,
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize20
                    : AppSize.appSize0,
            top: AppSize.appSize6,
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppSize.appSize24,
          left: AppSize.appSize20,
          right: AppSize.appSize20,
        ),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppSize.size2,
            crossAxisSpacing: AppSize.appSize20,
            mainAxisSpacing: AppSize.appSize20,
            mainAxisExtent: AppSize.appSize300,
          ),
          itemCount: AppSize.size3,
          itemBuilder: (context, index) {
            return Container(
              width: AppSize.appSize165,
              decoration: BoxDecoration(
                color: AppColor.cardBackgroundColor,
                borderRadius: BorderRadius.circular(AppSize.appSize12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.comment2,
                    width: AppSize.appSize52,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: AppSize.appSize9),
                    child: Text(
                      AppString.robertFox,
                      style: TextStyle(
                        fontSize: AppSize.appSize16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: AppSize.appSize104,
        child: Align(
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
      ),
    );
  }
}
