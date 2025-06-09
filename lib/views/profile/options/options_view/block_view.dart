// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/block_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_font.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_size.dart';
import '../../../../config/app_string.dart';

class BlockView extends StatelessWidget {
  BlockView({Key? key}) : super(key: key);

  BlockController blockController = Get.put(BlockController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  //Block content
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
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize12
                    : AppSize.appSize0,
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize12,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
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
              AppString.block,
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
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.appSize16,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: blockController.blockIDList.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Image.asset(
              blockController.blockIDImageList[index],
              width: blockController.blockImageWidthList[index],
            ),
            title: Text(
              blockController.blockIDList[index],
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
            subtitle: Text(
              blockController.blockIDList[index],
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.text2Color,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                  msg: AppString.userUnblocked,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: AppSize.size1,
                  backgroundColor: AppColor.cardBackgroundColor,
                  textColor: AppColor.secondaryColor,
                  fontSize: AppSize.appSize14,
                );
              },
              child: Container(
                width: AppSize.appSize110,
                height: AppSize.appSize32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.appSize6),
                  color: AppColor.primaryColor,
                ),
                child: const Center(
                  child: Text(
                    AppString.buttonTextUnblock,
                    style: TextStyle(
                      fontSize: AppSize.appSize14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFont.appFontSemiBold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
