import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/home/likes_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

likesBottomSheet(BuildContext context) {
  LikesController likesController = Get.put(LikesController());
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
                    AppString.likes,
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
                      likesController.searchController.clear();
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
            Padding(
              padding: const EdgeInsets.only(
                top: AppSize.appSize24,
                left: AppSize.appSize20,
                right: AppSize.appSize20,
              ),
              child: Container(
                height: AppSize.appSize48,
                padding: const EdgeInsets.only(
                  left: AppSize.appSize14,
                  right: AppSize.appSize14,
                ),
                decoration: BoxDecoration(
                  color: AppColor.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(AppSize.appSize12),
                  border: Border.all(
                      color: AppColor.borderColor,
                      width: AppSize.appSizePoint7),
                ),
                child: Center(
                  child: TextFormField(
                    controller: likesController.searchController,
                    cursorColor: AppColor.secondaryColor,
                    style: const TextStyle(
                      fontSize: AppSize.appSize14,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.appFontSemiBold,
                      color: AppColor.secondaryColor,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      hintText: AppString.search,
                      hintStyle: const TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text1Color,
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
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
                        child: Image.asset(AppIcon.searchLike),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        maxWidth: AppSize.appSize26,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.appSize24),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: likesController.likesIDList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: AppSize.appSize20,
                      right: AppSize.appSize20,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: GestureDetector(
                        onTap: () {
                          if (index == 0 ||
                              index == 3 ||
                              index == 4 ||
                              index == 5 ||
                              index == 7) {
                            Get.toNamed(AppRoutes.storyFullView);
                          }
                        },
                        child: Image.asset(
                          likesController.likesIDImageList[index],
                          width: likesController.likeImageWidthList[index],
                        ),
                      ),
                      title: Text(
                        likesController.likesIDList[index],
                        style: const TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      subtitle: Text(
                        likesController.likesIDList[index],
                        style: const TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text2Color,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          likesController.toggleFollow(index);
                        },
                        child: Obx(() => Container(
                              width: AppSize.appSize110,
                              height: AppSize.appSize32,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.appSize6),
                                color: likesController.isFollowList[index]
                                    ? AppColor.cardBackgroundColor
                                    : AppColor.primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  likesController.isFollowList[index]
                                      ? AppString.following
                                      : AppString.follow,
                                  style: const TextStyle(
                                    fontSize: AppSize.appSize14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFont.appFontSemiBold,
                                    color: AppColor.secondaryColor,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  ).then((result) {
    if (result == null || result == 'dismissed') {
      likesController.searchController.clear();
    }
  });
}
