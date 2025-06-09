// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/home/repost_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/widget/app_button.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_font.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_size.dart';

class RepostView extends StatelessWidget {
  RepostView({Key? key}) : super(key: key);

  RepostController repostController = Get.put(RepostController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  //Repost content
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
          top: AppSize.appSize6,
        ),
        child: GestureDetector(
          onTap: () {
            Get.back();
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
        Padding(
          padding: EdgeInsets.only(
            top: AppSize.appSize12,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize20
                    : AppSize.appSize0,
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize20,
          ),
          child: AppButton(
            text: AppString.repost,
            onPressed: () {
              Get.back();
              Get.back();
            },
            height: AppSize.appSize34,
            width: AppSize.appSize100,
            backgroundColor: AppColor.primaryColor,
            textColor: AppColor.secondaryColor,
          ),
        ),
      ],
    );
  }

  _body() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
          left: AppSize.appSize20, right: AppSize.appSize20),
      child: Column(
        children: [
          Container(
            height: AppSize.appSize480,
            margin: const EdgeInsets.only(top: AppSize.appSize31),
            padding: const EdgeInsets.all(AppSize.appSize12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.appSize12),
              border: Border.all(color: AppColor.lineColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize10
                                : AppSize.appSize0,
                            right: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize0
                                : AppSize.appSize10,
                          ),
                          child: Image.asset(
                            AppImage.profile1,
                            width: AppSize.appSize32,
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.davidMorel,
                              style: TextStyle(
                                fontSize: AppSize.appSize12,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFont.appFontSemiBold,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                            Text(
                              AppString.india,
                              style: TextStyle(
                                fontSize: AppSize.appSize12,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color: AppColor.text2Color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      AppString.days9,
                      style: TextStyle(
                        fontSize: AppSize.appSize12,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text1Color,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize10,
                  ),
                  child: Image.asset(
                    AppImage.post1,
                    width: kIsWeb ? AppSize.appSize350 : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize12),
                  child: RichText(
                    text: const TextSpan(
                      text: AppString.davidMorelID,
                      style: TextStyle(
                        fontSize: AppSize.appSize12,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFont.appFontBold,
                        color: AppColor.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: AppString.loremString,
                          style: TextStyle(
                            fontSize: AppSize.appSize12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFont.appFontRegular,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(
              AppImage.profile4,
              width: AppSize.appSize32,
            ),
            title: TextFormField(
              cursorColor: AppColor.secondaryColor,
              controller: repostController.commentsController,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(bottom: AppSize.appSize4),
                hintText: AppString.addComments,
                hintStyle: TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontRegular,
                  color: AppColor.text2Color,
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
            ),
          ),
        ],
      ),
    );
  }
}
