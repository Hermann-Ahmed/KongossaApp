import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';
import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

repostBottomSheet(BuildContext context) {
  LanguageController languageController = Get.put(LanguageController());
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
        height: AppSize.appSize202,
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
              margin: const EdgeInsets.only(bottom: AppSize.appSize24),
              decoration: BoxDecoration(
                color: AppColor.lineColor,
                borderRadius: BorderRadius.circular(
                  AppSize.appSize6,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: AppSize.appSize20,
                  right: AppSize.appSize20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize12
                                : AppSize.appSize0,
                            right: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize0
                                : AppSize.appSize12,
                          ),
                          child: Image.asset(
                            AppIcon.repostQuote,
                            width: AppSize.appSize24,
                          ),
                        ),
                        Expanded(
                          child: Column(
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
                                child: const Text(
                                  AppString.repost,
                                  style: TextStyle(
                                    fontSize: AppSize.appSize16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.appFontSemiBold,
                                    color: AppColor.secondaryColor,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: AppSize.appSize2),
                                child: Text(
                                  AppString.shareThisPostWithYourAudience,
                                  style: TextStyle(
                                    fontSize: AppSize.appSize14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppFont.appFontRegular,
                                    color: AppColor.text2Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppSize.appSize32),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.repostView);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: languageController
                                            .selectedLanguageIndex.value ==
                                        AppSize.size2
                                    ? AppSize.appSize12
                                    : AppSize.appSize0,
                                right: languageController
                                            .selectedLanguageIndex.value ==
                                        AppSize.size2
                                    ? AppSize.appSize0
                                    : AppSize.appSize12,
                              ),
                              child: Image.asset(
                                AppIcon.edit,
                                width: AppSize.appSize24,
                              ),
                            ),
                            Expanded(
                              child: Column(
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
                                    child: const Text(
                                      AppString.repostWithQuote,
                                      style: TextStyle(
                                        fontSize: AppSize.appSize16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: AppFont.appFontSemiBold,
                                        color: AppColor.secondaryColor,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: AppSize.appSize2),
                                    child: Text(
                                      AppString.beforeSharingThisPost,
                                      style: TextStyle(
                                        fontSize: AppSize.appSize14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFont.appFontRegular,
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
