// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';

class ShareViewDialog extends StatelessWidget {
  const ShareViewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppSize.appSize20,
            right: AppSize.appSize20,
            bottom: AppSize.appSize80),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: kIsWeb ? AppSize.appSize800 : AppSize.appSize370,
            height: AppSize.appSize100,
            padding: const EdgeInsets.only(
                left: AppSize.appSize14, right: AppSize.appSize14),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImage.document,
                      width: AppSize.appSize48,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: AppSize.appSize6),
                      child: Text(
                        AppString.document,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImage.cameraShare,
                      width: AppSize.appSize48,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: AppSize.appSize6),
                      child: Text(
                        AppString.camera,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImage.gallery,
                      width: AppSize.appSize48,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: AppSize.appSize6),
                      child: Text(
                        AppString.gallery,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImage.poll,
                      width: AppSize.appSize48,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: AppSize.appSize6),
                      child: Text(
                        AppString.poll,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
