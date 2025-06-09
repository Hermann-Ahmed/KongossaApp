// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/forgot_password/code_confirmation_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

import '../../config/app_color.dart';
import '../../config/app_font.dart';
import '../../config/app_icon.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';
import '../../widget/app_button.dart';
import '../../widget/app_textfield.dart';

class CodeConfirmationView extends StatelessWidget {
  CodeConfirmationView({Key? key}) : super(key: key);

  CodeConfirmationController codeConfirmationController =
      Get.put(CodeConfirmationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  //Code confirmation content
  _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: AppSize.appSize20),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppIcon.back),
        ),
      ),
      leadingWidth: AppSize.appSize44,
    );
  }

  _body() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: AppSize.appSize24),
            child: Text(
              AppString.confirmationCode,
              style: TextStyle(
                fontSize: AppSize.appSize24,
                fontWeight: FontWeight.w700,
                fontFamily: AppFont.appFontBold,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: AppSize.appSize8),
            child: Text(
              AppString.confirmationCodeString,
              style: TextStyle(
                fontSize: AppSize.appSize16,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.text2Color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: codeConfirmationController.confirmationCodeController,
              labelText: AppString.confirmationCodeField,
              keyboardType: TextInputType.number,
              cursorColor: AppColor.secondaryColor,
              fillColor: AppColor.cardBackgroundColor,
              inputFormatters: [
                LengthLimitingTextInputFormatter(AppSize.size6),
              ],
              textInputAction: TextInputAction.done,
            ),
          ),
          AppButton(
            onPressed: () {
              Get.toNamed(AppRoutes.resetPasswordView);
            },
            text: AppString.buttonTextNext,
            backgroundColor: AppColor.primaryColor,
            margin: const EdgeInsets.only(top: AppSize.appSize32),
          ),
        ],
      ),
    );
  }
}
