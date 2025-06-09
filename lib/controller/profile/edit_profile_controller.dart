import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kongossa/config/app_string.dart';

import '../../config/app_color.dart';

class EditProfileController extends GetxController {
  TextEditingController nameController =
      TextEditingController(text: AppString.eleanorPena);
  TextEditingController usernameController =
      TextEditingController(text: AppString.eleanorPenaID);
  TextEditingController bioController =
      TextEditingController(text: AppString.loremString6);
  TextEditingController genderController =
      TextEditingController(text: AppString.male);
  TextEditingController dobController =
      TextEditingController(text: AppString.dob);
  TextEditingController mobileNumberController =
      TextEditingController(text: AppString.phoneHint2);

  Rx<DateTime?> selectedDate = DateTime.now().obs;
  RxInt selectedGenderIndex = 0.obs;
  RxString profileImagePath = ''.obs;

  Future<void> updateProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }

  String get selectedGender {
    if (selectedGenderIndex.value >= 0 &&
        selectedGenderIndex.value < genderList.length) {
      return genderList[selectedGenderIndex.value];
    } else {
      return '';
    }
  }

  void selectGender(int index) {
    selectedGenderIndex.value = index;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      keyboardType: TextInputType.datetime,
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      String formattedDate =
          DateFormat(AppString.dateFormatString).format(picked);
      dobController.text = formattedDate;
    }
  }

  RxList<String> genderList = [
    AppString.male,
    AppString.female,
  ].obs;
}
