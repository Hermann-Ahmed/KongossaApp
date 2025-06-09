// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/controller/home/reels_play_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class ReelsView extends StatelessWidget {
  ReelsView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    ReelsPlayController reelsPlayController = Get.put(ReelsPlayController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(reelsPlayController),
      ),
    );
  }

  //Reels view content
  _body(ReelsPlayController reelsPlayController) {
    return PageView.builder(
      itemCount: AppSize.size10,
      controller: reelsPlayController.pageController,
      onPageChanged: (index) {
        reelsPlayController.onPageChanged(index);
      },
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                AppImage.reelVideoImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: AppSize.appSize0,
              child: Obx(() => Container(
                    height: reelsPlayController.isExpanded.value
                        ? AppSize.appSize230
                        : AppSize.appSize78,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: AppSize.appSize20,
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize20
                          : AppSize.appSize0,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(AppSize.appSizePoint6),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: languageController
                                            .selectedLanguageIndex.value ==
                                        AppSize.size2
                                    ? AppSize.appSize0
                                    : AppSize.appSize10,
                                left: languageController
                                            .selectedLanguageIndex.value ==
                                        AppSize.size2
                                    ? AppSize.appSize10
                                    : AppSize.appSize0,
                              ),
                              child: Image.asset(
                                AppImage.profile4,
                                width: AppSize.appSize36,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      AppString.marvinID,
                                      style: TextStyle(
                                        fontSize: AppSize.appSize14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: AppFont.appFontSemiBold,
                                        color: AppColor.secondaryColor,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        reelsPlayController.toggleFollow();
                                      },
                                      child: Obx(() => Container(
                                            height: AppSize.appSize26,
                                            width: AppSize.appSize82,
                                            margin: EdgeInsets.only(
                                              left: AppSize.appSize8,
                                              right: languageController
                                                          .selectedLanguageIndex
                                                          .value ==
                                                      AppSize.size2
                                                  ? AppSize.appSize8
                                                  : AppSize.appSize0,
                                              top: AppSize.appSize4,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColor.secondaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.appSize6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                reelsPlayController
                                                        .isFollow.value
                                                    ? AppString.following
                                                    : AppString.follow,
                                                style: const TextStyle(
                                                  fontSize: AppSize.appSize12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                      AppFont.appFontSemiBold,
                                                  color:
                                                      AppColor.secondaryColor,
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppSize.appSize8),
                          child: GestureDetector(
                            onTap: () {
                              reelsPlayController.toggleExpanded();
                            },
                            child: SizedBox(
                              width: AppSize.appSize329,
                              child: Text(
                                reelsPlayController.isExpanded.value
                                    ? AppString.loremIpsumExpanded
                                    : AppString.loremIpsumIsSimplyDummy,
                                style: const TextStyle(
                                  fontSize: AppSize.appSize12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppFont.appFontRegular,
                                  color: AppColor.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Positioned(
              bottom: AppSize.appSize0,
              right: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? null
                  : AppSize.appSize0,
              left: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? AppSize.appSize0
                  : null,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: AppSize.appSize60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    end: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    tileMode: TileMode.mirror,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(AppSize.appSizePoint6),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: AppSize.appSize8,
              right: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? null
                  : AppSize.appSize12,
              left: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? AppSize.appSize12
                  : null,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: AppSize.appSize12, bottom: AppSize.appSize14),
                child: Column(
                  children: [
                    Obx(() {
                      bool isLiked = reelsPlayController.isLiked.value;
                      return _photoOptionWidget(
                        isLiked ? AppIcon.like : AppIcon.emptyLike,
                        AppSize.appSize26,
                        AppString.likes55k,
                        onTap: () {
                          reelsPlayController.toggleLike();
                        },
                      );
                    }),
                    _photoOptionWidget(AppIcon.comment, AppSize.appSize24,
                        AppString.comment10k),
                    _photoOptionWidget(
                        AppIcon.repost, AppSize.appSize27, AppString.repost15k),
                    _photoOptionWidget(
                        AppIcon.share, AppSize.appSize24, AppString.share5k),
                    _photoOptionWidget(
                        AppIcon.save, AppSize.appSize24, AppString.save2k),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppSize.appSize20,
                  top: AppSize.appSize14,
                  right: AppSize.appSize20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize0
                                  : AppSize.appSize6,
                          left:
                              languageController.selectedLanguageIndex.value ==
                                      AppSize.size2
                                  ? AppSize.appSize6
                                  : AppSize.appSize0,
                        ),
                        child: Image.asset(
                          AppIcon.arrowRightUp,
                          width: AppSize.appSize14,
                        ),
                      ),
                      const Text(
                        AppString.martinGarrixSong,
                        style: TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      reelsPlayController.openCamera();
                    },
                    child: Image.asset(
                      AppIcon.camera,
                      width: AppSize.appSize20,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              bool showHeartIcon = reelsPlayController.showHeartIcon.value;
              return showHeartIcon
                  ? const Center(
                      child: Icon(
                        Icons.favorite_rounded,
                        color: AppColor.supportColor,
                        size: AppSize.appSize85,
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ],
        );
      },
    );
  }

  _photoOptionWidget(String icon, double width, String text,
      {void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.appSize14),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSize.appSize2),
              child: Image.asset(
                icon,
                width: width,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: AppSize.appSize14,
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
}
