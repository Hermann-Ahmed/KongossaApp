import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/controller/new_post/new_post_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

newPostOptionsBottomSheet(BuildContext context) {
  NewPostController newPostController = Get.put(NewPostController());
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSize.appSize28,
              height: AppSize.appSize2,
              margin: const EdgeInsets.only(bottom: AppSize.appSize20),
              decoration: BoxDecoration(
                color: AppColor.lineColor,
                borderRadius: BorderRadius.circular(
                  AppSize.appSize6,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: newPostController.newPostOptionsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    newPostController.selectItem(index);
                    if (index == 0) {
                      Get.back();
                      Get.toNamed(AppRoutes.createReelView);
                    }
                  },
                  child: Obx(() => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: AppSize.appSize15),
                        margin: const EdgeInsets.only(
                          bottom: AppSize.appSize8,
                          left: AppSize.appSize14,
                          right: AppSize.appSize14,
                        ),
                        decoration: BoxDecoration(
                          color: newPostController.isSelected.value == index
                              ? AppColor.cardBackgroundColor
                              : AppColor.transparentColor,
                          borderRadius:
                              BorderRadius.circular(AppSize.appSize12),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: AppSize.appSize12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              newPostController.newPostOptionsList[index],
                              style: const TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFont.appFontSemiBold,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
