// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/controller/new_post/reel_edit_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class ReelEditView extends StatelessWidget {
  ReelEditView({Key? key}) : super(key: key);

  ReelEditController reelEditController = Get.put(ReelEditController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _appBar(),
        body: _body(),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  //Reel Edit content
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
                AppString.buttonTextSave,
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
      padding: const EdgeInsets.only(bottom: AppSize.appSize10),
      child: Column(
        children: [
          Container(
            height: AppSize.appSize570,
            padding: const EdgeInsets.only(
              left: AppSize.appSize20,
              right: AppSize.appSize20,
              top: AppSize.appSize23,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSize.appSize12),
                bottomRight: Radius.circular(AppSize.appSize12),
              ),
              color: AppColor.cardBackgroundColor,
            ),
            child: Column(
              children: [
                Image.asset(
                  AppImage.reelImage,
                  width: kIsWeb ? AppSize.appSize350 : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: AppSize.appSize10),
                            child: Image.asset(
                              AppIcon.reply,
                              width: AppSize.appSize20,
                            ),
                          ),
                          Image.asset(
                            AppIcon.forward,
                            width: AppSize.appSize20,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize30
                                  : AppSize.appSize0,
                          right:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize30,
                        ),
                        child: Image.asset(
                          AppIcon.play,
                          width: AppSize.appSize32,
                        ),
                      ),
                      Image.asset(
                        AppIcon.fullScreen,
                        width: AppSize.appSize20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              SizedBox(
                height: AppSize.appSize145,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: AppSize.appSize30),
                      padding: const EdgeInsets.only(left: AppSize.appSize34),
                      height: AppSize.appSize42,
                      color: AppColor.cardBackgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            AppIcon.add2,
                            width: AppSize.appSize34,
                          ),
                          Image.asset(
                            AppImage.reelAdd,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: AppSize.appSize10),
                      height: AppSize.appSize24,
                      color: AppColor.cardBackgroundColor,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: AppSize.appSize321,
                          padding: const EdgeInsets.only(
                            left: AppSize.appSize8,
                            bottom: AppSize.appSize2,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColor.container2Color,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.appSize6),
                              bottomLeft: Radius.circular(AppSize.appSize6),
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppString.musicOfMusic,
                              style: TextStyle(
                                fontSize: AppSize.appSize12,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color: AppColor.backgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: AppSize.appSize16),
                      child: Text(
                        AppString.reelEditTime,
                        style: TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text1Color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: AppSize.appSize2,
                  height: AppSize.appSize118,
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _bottomBar() {
    return Container(
      height: AppSize.appSize54,
      color: AppColor.cardBackgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: reelEditController.reelEditIcon.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: AppSize.appSize6,
              bottom: AppSize.appSize6,
              left: AppSize.appSize14,
              right: AppSize.appSize2,
            ),
            child: GestureDetector(
              onTap: () {
                reelEditController.selectItem(index);
              },
              child: Obx(() => SizedBox(
                    width: AppSize.appSize43,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              reelEditController.reelEditIcon[index],
                              width: AppSize.appSize20,
                              color:
                                  reelEditController.isSelected.value == index
                                      ? AppColor.primaryColor
                                      : AppColor.secondaryColor,
                            ),
                            Text(
                              reelEditController.reelEditString[index],
                              style: TextStyle(
                                fontSize: AppSize.appSize12,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color:
                                    reelEditController.isSelected.value == index
                                        ? AppColor.primaryColor
                                        : AppColor.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
