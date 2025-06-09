import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/home/comments_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';

LanguageController languageController = Get.put(LanguageController());

commentsBottomSheet(BuildContext context) {
  CommentsController commentsController = Get.put(CommentsController());
  return showModalBottomSheet(
    backgroundColor: AppColor.backgroundColor,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.appSize12),
        topRight: Radius.circular(AppSize.appSize12),
      ),
      borderSide: BorderSide.none,
    ),
    constraints: const BoxConstraints(
      maxWidth: kIsWeb ? AppSize.appSize800 : double.infinity,
    ),
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Container(
        height: AppSize.appSize715,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          top: AppSize.appSize12,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSize.appSize12),
            topRight: Radius.circular(AppSize.appSize12),
          ),
          color: AppColor.backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              width: AppSize.appSize28,
              height: AppSize.appSize2,
              margin: const EdgeInsets.only(bottom: AppSize.appSize12),
              decoration: BoxDecoration(
                color: AppColor.lineColor,
                borderRadius: BorderRadius.circular(
                  AppSize.appSize6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSize.appSize16,
                left: AppSize.appSize20,
                right: AppSize.appSize20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppString.comments,
                    style: TextStyle(
                      fontSize: AppSize.appSize16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFont.appFontSemiBold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      commentsController.commentsFieldController.clear();
                    },
                    child: Image.asset(
                      AppIcon.close,
                      width: AppSize.appSize24,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColor.lineColor,
              height: AppSize.appSize0,
              endIndent: AppSize.appSize20,
              indent: AppSize.appSize20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: AppSize.appSize24,
                  left: AppSize.appSize20,
                  right: AppSize.appSize20,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize8
                                : AppSize.appSize0,
                            right: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize0
                                : AppSize.appSize8,
                          ),
                          child: Image.asset(
                            AppImage.comment1,
                            width: AppSize.appSize40,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: languageController
                                                      .selectedLanguageIndex
                                                      .value ==
                                                  AppSize.size2
                                              ? AppSize.appSize8
                                              : AppSize.appSize0,
                                          right: languageController
                                                      .selectedLanguageIndex
                                                      .value ==
                                                  AppSize.size2
                                              ? AppSize.appSize0
                                              : AppSize.appSize8,
                                        ),
                                        child: const Text(
                                          AppString.eleanorPena,
                                          style: TextStyle(
                                            fontSize: AppSize.appSize14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: AppFont.appFontSemiBold,
                                            color: AppColor.secondaryColor,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        AppString.min33,
                                        style: TextStyle(
                                          fontSize: AppSize.appSize14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppFont.appFontRegular,
                                          color: AppColor.text1Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: languageController
                                                      .selectedLanguageIndex
                                                      .value ==
                                                  AppSize.size2
                                              ? AppSize.appSize4
                                              : AppSize.appSize0,
                                          right: languageController
                                                      .selectedLanguageIndex
                                                      .value ==
                                                  AppSize.size2
                                              ? AppSize.appSize0
                                              : AppSize.appSize4,
                                        ),
                                        child: Image.asset(
                                          AppIcon.emptyLike,
                                          width: AppSize.appSize18,
                                        ),
                                      ),
                                      const Text(
                                        AppString.likes55k,
                                        style: TextStyle(
                                          fontSize: AppSize.appSize12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: AppFont.appFontSemiBold,
                                          color: AppColor.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: AppSize.appSize4),
                                child: Text(
                                  AppString.loremString,
                                  style: TextStyle(
                                    fontSize: AppSize.appSize14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppFont.appFontRegular,
                                    color: AppColor.text2Color,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: AppSize.appSize4),
                                child: Text(
                                  AppString.reply,
                                  style: TextStyle(
                                    fontSize: AppSize.appSize14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.appFontSemiBold,
                                    color: AppColor.text2Color,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: AppSize.appSize18),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize8
                                            : AppSize.appSize0,
                                        right: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize0
                                            : AppSize.appSize8,
                                      ),
                                      child: Image.asset(
                                        AppImage.comment2,
                                        width: AppSize.appSize29,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize8
                                                          : AppSize.appSize0,
                                                      right: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize0
                                                          : AppSize.appSize8,
                                                    ),
                                                    child: const Text(
                                                      AppString.bessieCooper,
                                                      style: TextStyle(
                                                        fontSize:
                                                            AppSize.appSize12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: AppFont
                                                            .appFontSemiBold,
                                                        color: AppColor
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    AppString.day1,
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.appSize12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: AppFont
                                                          .appFontRegular,
                                                      color:
                                                          AppColor.text1Color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize4
                                                          : AppSize.appSize0,
                                                      right: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize0
                                                          : AppSize.appSize4,
                                                    ),
                                                    child: Image.asset(
                                                      AppIcon.emptyLike,
                                                      width: AppSize.appSize18,
                                                    ),
                                                  ),
                                                  const Text(
                                                    AppString.likes15k,
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.appSize12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: AppFont
                                                          .appFontSemiBold,
                                                      color: AppColor
                                                          .secondaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: AppSize.appSize4),
                                            child: Text(
                                              AppString.loremString2,
                                              style: TextStyle(
                                                fontSize: AppSize.appSize14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    AppFont.appFontRegular,
                                                color: AppColor.text2Color,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: AppSize.appSize4),
                                            child: Text(
                                              AppString.reply,
                                              style: TextStyle(
                                                fontSize: AppSize.appSize14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily:
                                                    AppFont.appFontSemiBold,
                                                color: AppColor.text2Color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: AppSize.appSize18),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize8
                                            : AppSize.appSize0,
                                        right: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize0
                                            : AppSize.appSize8,
                                      ),
                                      child: Image.asset(
                                        AppImage.comment3,
                                        width: AppSize.appSize29,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize8
                                                          : AppSize.appSize0,
                                                      right: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize0
                                                          : AppSize.appSize8,
                                                    ),
                                                    child: const Text(
                                                      AppString.kathrynMurphy,
                                                      style: TextStyle(
                                                        fontSize:
                                                            AppSize.appSize12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: AppFont
                                                            .appFontSemiBold,
                                                        color: AppColor
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    AppString.day2,
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.appSize12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: AppFont
                                                          .appFontRegular,
                                                      color:
                                                          AppColor.text1Color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize4
                                                          : AppSize.appSize0,
                                                      right: languageController
                                                                  .selectedLanguageIndex
                                                                  .value ==
                                                              AppSize.size2
                                                          ? AppSize.appSize0
                                                          : AppSize.appSize4,
                                                    ),
                                                    child: Image.asset(
                                                      AppIcon.emptyLike,
                                                      width: AppSize.appSize18,
                                                    ),
                                                  ),
                                                  const Text(
                                                    AppString.likes5k,
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppSize.appSize12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: AppFont
                                                          .appFontSemiBold,
                                                      color: AppColor
                                                          .secondaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: AppSize.appSize4),
                                            child: Text(
                                              AppString.loremString3,
                                              style: TextStyle(
                                                fontSize: AppSize.appSize14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    AppFont.appFontRegular,
                                                color: AppColor.text2Color,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: AppSize.appSize4),
                                            child: Text(
                                              AppString.reply,
                                              style: TextStyle(
                                                fontSize: AppSize.appSize14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily:
                                                    AppFont.appFontSemiBold,
                                                color: AppColor.text2Color,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    _customChatMessage(
                        AppImage.comment4,
                        AppString.codyFisher,
                        AppString.minutes2,
                        AppString.loremString2,
                        AppString.likes55k),
                    _customChatMessage(
                        AppImage.comment5,
                        AppString.courtneyHenry,
                        AppString.min33,
                        AppString.loremString3,
                        AppString.likes15k),
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSize.appSize12),
                      child: _customChatMessage(
                          AppImage.comment6,
                          AppString.theresaWebb,
                          AppString.day2,
                          AppString.loremString2,
                          AppString.likes15k),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: AppSize.appSize58,
              padding: const EdgeInsets.only(
                left: AppSize.appSize20,
                right: AppSize.appSize20,
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: AppColor.cardBackgroundColor,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                  AppImage.profile4,
                  width: AppSize.appSize32,
                ),
                title: TextFormField(
                  cursorColor: AppColor.secondaryColor,
                  controller: commentsController.commentsFieldController,
                  textInputAction: TextInputAction.newline,
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
                trailing: Image.asset(
                  AppIcon.send,
                  width: AppSize.appSize24,
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).then((result) {
    if (result == null || result == 'dismissed') {
      commentsController.commentsFieldController.clear();
    }
  });
}

_customChatMessage(String image, String username, String time,
    String description, String likes) {
  return Padding(
    padding: const EdgeInsets.only(top: AppSize.appSize16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize8
                    : AppSize.appSize0,
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize8,
          ),
          child: Image.asset(
            image,
            width: AppSize.appSize40,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize8
                                  : AppSize.appSize0,
                          right:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize8,
                        ),
                        child: Text(
                          username,
                          style: const TextStyle(
                            fontSize: AppSize.appSize14,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.appFontSemiBold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text1Color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize4
                                  : AppSize.appSize0,
                          right:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize4,
                        ),
                        child: Image.asset(
                          AppIcon.emptyLike,
                          width: AppSize.appSize18,
                        ),
                      ),
                      Text(
                        likes,
                        style: const TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.appSize4),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.text2Color,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: AppSize.appSize4),
                child: Text(
                  AppString.reply,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.text2Color,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
