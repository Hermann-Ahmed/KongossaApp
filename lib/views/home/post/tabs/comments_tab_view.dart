import 'package:flutter/material.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_string.dart';

import '../../../../config/app_icon.dart';
import '../../../../config/app_size.dart';

class CommentsTabView extends StatelessWidget {
  const CommentsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: ListView.builder(
        itemCount: AppSize.size3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSize.appSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppString.loremString,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.secondaryColor,
                  ),
                ),
                if (index == 2) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize10),
                    child: Image.asset(
                      AppImage.commentImage,
                    ),
                  ),
                ],
                if (index == 1) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: AppSize.appSize18),
                    child: Text(
                      AppString.postTags,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFont.appFontSemiBold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.appSize14, bottom: AppSize.appSize14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _photoOptionWidget(AppIcon.comment, AppSize.appSize22,
                          AppString.comment10k),
                      _photoOptionWidget(AppIcon.repost, AppSize.appSize25,
                          AppString.repost15k),
                      _photoOptionWidget(
                          AppIcon.like, AppSize.appSize24, AppString.likes55k),
                      _photoOptionWidget(
                          AppIcon.share, AppSize.appSize22, AppString.share5k),
                      _photoOptionWidget(
                          AppIcon.save, AppSize.appSize22, AppString.save2k),
                    ],
                  ),
                ),
                _customDivider(),
              ],
            ),
          );
        },
      ),
    );
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

  _customDivider() {
    return const Divider(
      color: AppColor.lineColor,
      height: AppSize.appSize0,
    );
  }
}
