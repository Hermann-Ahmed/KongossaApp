// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/controller/home/all_post_controller.dart';

import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_string.dart';

class PostViewDialog extends StatelessWidget {
  final String imageUrl;
  PostViewDialog({required this.imageUrl, super.key});

  AllPostController allPostController = Get.put(AllPostController());

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppSize.appSize20, right: AppSize.appSize20),
        child: Center(
          child: Container(
            width: AppSize.appSize355,
            height: AppSize.appSize273,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: Column(
              children: [
                Container(
                  height: AppSize.appSize218,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.appSize12),
                      topRight: Radius.circular(AppSize.appSize12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize15,
                    left: AppSize.appSize20,
                    right: AppSize.appSize20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _photoOptionWidget(AppIcon.comment, AppSize.appSize22,
                          AppString.comment10k),
                      Obx(() {
                        bool isLiked = allPostController.isLiked.value;
                        return _photoOptionWidget(
                          isLiked ? AppIcon.like : AppIcon.emptyLike,
                          AppSize.appSize24,
                          AppString.likes55k,
                          onTap: () {
                            allPostController.toggleLike();
                          },
                        );
                      }),
                      _photoOptionWidget(
                          AppIcon.share, AppSize.appSize22, AppString.share5k),
                      _photoOptionWidget(
                          AppIcon.save, AppSize.appSize22, AppString.save2k),
                    ],
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

_photoOptionWidget(String icon, double width, String text,
    {void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppSize.appSize6),
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
  );
}
