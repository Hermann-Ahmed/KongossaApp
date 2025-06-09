// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/controller/profile/edit_profile_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/views/widget/profile/select_gender_popup.dart';

import '../../config/app_color.dart';
import '../../config/app_font.dart';
import '../../config/app_icon.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';
import '../../widget/app_button.dart';
import '../../widget/app_textfield.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({Key? key}) : super(key: key);

  EditProfileController editProfileController =
      Get.put(EditProfileController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(context),
    );
  }

  //Edit Profile content
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
              AppString.buttonTextEditProfile,
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

  _body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: AppSize.appSize16,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Obx(() => Container(
                      width: AppSize.appSize100,
                      height: AppSize.appSize100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.appSize66),
                      ),
                      child: Center(
                        child:
                            editProfileController.profileImagePath.value.isEmpty
                                ? Image.asset(
                                    AppImage.callProfile1,
                                    width: AppSize.appSize82,
                                  )
                                : CircleAvatar(
                                    backgroundColor: AppColor.backgroundColor,
                                    backgroundImage: FileImage(
                                      File(editProfileController
                                          .profileImagePath.value),
                                    ),
                                    radius: AppSize.appSize37,
                                  ),
                      ),
                    )),
                Positioned(
                  bottom: AppSize.appSize11,
                  right: AppSize.appSize12,
                  child: GestureDetector(
                    onTap: () {
                      editProfileController.updateProfileImage();
                    },
                    child: Image.asset(
                      AppIcon.editProfile,
                      width: AppSize.appSize24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: editProfileController.nameController,
              labelText: AppString.name,
              fillColor: AppColor.cardBackgroundColor,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: editProfileController.usernameController,
              labelText: AppString.username,
              fillColor: AppColor.cardBackgroundColor,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: editProfileController.bioController,
              labelText: AppString.bio,
              fillColor: AppColor.cardBackgroundColor,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: editProfileController.genderController,
              labelText: AppString.gender,
              fillColor: AppColor.cardBackgroundColor,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  left: languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppSize.appSize16
                      : AppSize.appSize0,
                  right: languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppSize.appSize0
                      : AppSize.appSize16,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SelectGenderPopup(
                        onGenderSelected: (selectedGender) {
                          editProfileController.genderController.text =
                              selectedGender;
                        },
                      ),
                    );
                  },
                  child: Image.asset(AppIcon.dropdown),
                ),
              ),
              suffixIconColor: AppColor.text2Color,
              suffixIconConstraints: const BoxConstraints(
                maxWidth: AppSize.appSize37,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: editProfileController.dobController,
              labelText: AppString.dateOfBirth,
              fillColor: AppColor.cardBackgroundColor,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  left: languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppSize.appSize16
                      : AppSize.appSize0,
                  right: languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppSize.appSize0
                      : AppSize.appSize16,
                ),
                child: GestureDetector(
                  onTap: () {
                    editProfileController.selectDate(context);
                  },
                  child: Image.asset(AppIcon.calendar),
                ),
              ),
              suffixIconColor: AppColor.text2Color,
              suffixIconConstraints: const BoxConstraints(
                maxWidth: AppSize.appSize35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: editProfileController.mobileNumberController,
              labelText: AppString.mobileNumber,
              fillColor: AppColor.cardBackgroundColor,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                LengthLimitingTextInputFormatter(AppSize.size10),
              ],
            ),
          ),
          AppButton(
            onPressed: () {
              Get.back();
            },
            text: AppString.buttonTextSubmit,
            backgroundColor: AppColor.primaryColor,
            margin: const EdgeInsets.only(
                top: AppSize.appSize48, bottom: AppSize.appSize10),
          ),
        ],
      ),
    );
  }
}
