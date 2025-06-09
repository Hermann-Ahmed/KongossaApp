// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/profile/edit_profile_controller.dart';

class SelectGenderPopup extends StatelessWidget {
  final Function(String) onGenderSelected;
  SelectGenderPopup({super.key, required this.onGenderSelected});

  EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSize.appSize46,
            right: AppSize.appSize46,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSize.appSize14),
            width: AppSize.appSize298,
            height: AppSize.appSize220,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppString.selectGender,
                  style: TextStyle(
                    fontSize: AppSize.appSize16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.secondaryColor,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: editProfileController.genderList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        editProfileController.selectGender(index);
                      },
                      child: Obx(() => Container(
                            height: AppSize.appSize48,
                            margin:
                                const EdgeInsets.only(bottom: AppSize.appSize8),
                            padding:
                                const EdgeInsets.only(left: AppSize.appSize14),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSize.appSize12),
                              color: editProfileController
                                          .selectedGenderIndex.value ==
                                      index
                                  ? AppColor.cardBackgroundColor
                                  : AppColor.transparentColor,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                editProfileController.genderList[index],
                                style: const TextStyle(
                                  fontSize: AppSize.appSize14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppFont.appFontRegular,
                                  color: AppColor.secondaryColor,
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: AppSize.appSize16),
                      child: Text(
                        AppString.cancelText,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.text1Color,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        onGenderSelected(editProfileController.selectedGender);
                      },
                      child: const Text(
                        AppString.setText,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.primaryColor,
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
