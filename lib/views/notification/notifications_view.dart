// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/controller/bottom_bar/bottom_bar_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import '../../config/app_font.dart';
import '../../config/app_icon.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  //Notification content
  _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      scrolledUnderElevation: AppSize.appSize0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(
            top: AppSize.appSize12, left: AppSize.appSize6),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: AppSize.appSize12,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize13
                    : AppSize.appSize0,
              ),
              child: GestureDetector(
                onTap: () {
                  BottomBarController bottomBarController =
                      Get.put(BottomBarController());
                  bottomBarController.pageController.jumpToPage(0);
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
            const Text(
              AppString.notifications,
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
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.appSize24,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize10,
      ),
      child: Column(
        children: [
          _customNotification(
            container: Container(
              width: AppSize.appSize62,
              height: AppSize.appSize62,
              margin: EdgeInsets.only(
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize14,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize14
                    : AppSize.appSize0,
                top: AppSize.appSize6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.appSize6),
                color: AppColor.containerColor,
              ),
            ),
            text1: AppString.loremIpsum,
            text2: AppString.loremString2,
            text3: AppString.hours4Ago,
          ),
          _customNotification(
            container: Container(
              width: AppSize.appSize62,
              height: AppSize.appSize62,
              margin: EdgeInsets.only(
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize14,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize14
                    : AppSize.appSize0,
                top: AppSize.appSize6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.appSize6),
                color: AppColor.containerColor,
              ),
            ),
            text1: AppString.loremIpsum,
            text2: AppString.loremIpsumText2,
            text3: AppString.yesterday,
          ),
          _customNotification(
            text1: AppString.loremIpsumText4,
            text2: AppString.loremIpsumText3,
            text3: AppString.thursday,
          ),
          _customNotification(
            text1: AppString.loremIpsumText4,
            text2: AppString.loremString2,
            text3: AppString.monday,
          ),
          _customNotification(
            container: Container(
              width: AppSize.appSize62,
              height: AppSize.appSize62,
              margin: EdgeInsets.only(
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize14,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize14
                    : AppSize.appSize0,
                top: AppSize.appSize6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.appSize6),
                color: AppColor.containerColor,
              ),
            ),
            text1: AppString.loremIpsum,
            text2: AppString.loremString2,
            text3: AppString.days4Ago,
          ),
          _customNotification(
            text1: AppString.loremIpsumText4,
            text2: AppString.loremIpsumText5,
            text3: AppString.days4Ago,
          ),
          _customNotification(
            container: Container(
              width: AppSize.appSize62,
              height: AppSize.appSize62,
              margin: EdgeInsets.only(
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize14,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize14
                    : AppSize.appSize0,
                top: AppSize.appSize6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.appSize6),
                color: AppColor.containerColor,
              ),
            ),
            text1: AppString.loremIpsum,
            text2: AppString.loremString2,
            text3: AppString.hours4Ago,
          ),
        ],
      ),
    );
  }

  _customNotification(
      {Widget? container, String? text1, String? text2, String? text3}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            container ?? const SizedBox.shrink(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    text1!,
                    style: const TextStyle(
                      fontSize: AppSize.appSize16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFont.appFontSemiBold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize1),
                    child: Text(
                      text2!,
                      style: const TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize2),
                    child: Text(
                      text3!,
                      style: const TextStyle(
                        fontSize: AppSize.appSize12,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: AppColor.lineColor,
          height: AppSize.appSize34,
        ),
      ],
    );
  }
}
