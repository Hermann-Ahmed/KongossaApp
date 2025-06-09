// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/account_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/widget/app_textfield.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_font.dart';
import '../../../../config/app_icon.dart';
import '../../../../config/app_size.dart';
import '../../../../config/app_string.dart';

class AccountView extends StatelessWidget {
  AccountView({Key? key}) : super(key: key);

  AccountController accountController = Get.put(AccountController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  //Account content
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
              AppString.account,
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
        top: AppSize.appSize24,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        children: [
          AppTextField(
            controller: accountController.emailController,
            labelText: AppString.emailID,
            fillColor: AppColor.cardBackgroundColor,
            keyboardType: TextInputType.emailAddress,
            readOnly: true,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.appSize24, bottom: AppSize.appSize24),
            child: AppTextField(
              controller: accountController.phoneNumberController,
              labelText: AppString.phoneNumber,
              fillColor: AppColor.cardBackgroundColor,
              keyboardType: TextInputType.phone,
              readOnly: true,
            ),
          ),
          AppTextField(
            controller: accountController.dateOfBirthController,
            labelText: AppString.dateOfBirth,
            fillColor: AppColor.cardBackgroundColor,
            keyboardType: TextInputType.datetime,
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
