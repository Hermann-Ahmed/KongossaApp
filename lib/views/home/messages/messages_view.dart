// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/home/messages_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class MessagesView extends StatelessWidget {
  MessagesView({Key? key}) : super(key: key);

  MessagesController messagesController = Get.put(MessagesController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  //Messages content
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
          left: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize0
              : AppSize.appSize20,
          right: languageController.selectedLanguageIndex.value == AppSize.size2
              ? AppSize.appSize20
              : AppSize.appSize0,
          top: AppSize.appSize6,
        ),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            languageController.selectedLanguageIndex.value == AppSize.size2
                ? AppIcon.backRight
                : AppIcon.back,
          ),
        ),
      ),
      leadingWidth: AppSize.appSize44,
      title: const Text(
        AppString.messages,
        style: TextStyle(
          fontSize: AppSize.appSize20,
          fontWeight: FontWeight.w600,
          fontFamily: AppFont.appFontSemiBold,
          color: AppColor.secondaryColor,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize20
                    : AppSize.appSize0,
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize20,
            top: AppSize.appSize5,
          ),
          child: GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: AppSize.appSize20,
              child: Image.asset(
                AppIcon.videoCamera,
                width: AppSize.appSize24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.appSize24,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        children: [
          Container(
            height: AppSize.appSize48,
            padding: const EdgeInsets.only(
              left: AppSize.appSize14,
              right: AppSize.appSize14,
            ),
            decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.appSize12),
              border: Border.all(
                  color: AppColor.borderColor, width: AppSize.appSizePoint7),
            ),
            child: Center(
              child: TextFormField(
                controller: messagesController.searchFieldController,
                cursorColor: AppColor.secondaryColor,
                style: const TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFont.appFontSemiBold,
                  color: AppColor.secondaryColor,
                ),
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: AppString.search,
                  hintStyle: const TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.text1Color,
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize8
                          : AppSize.appSize0,
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize0
                          : AppSize.appSize8,
                    ),
                    child: Image.asset(AppIcon.searchLike),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxWidth: AppSize.appSize22,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.appSize24, bottom: AppSize.appSize24),
            child: SizedBox(
              height: AppSize.appSize36,
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return _buildTabButton(0, AppString.messages,
                          messagesController.selectedIndex.value == 0);
                    }),
                  ),
                  const SizedBox(
                    width: AppSize.appSize20,
                  ),
                  Expanded(
                    child: Obx(() {
                      return _buildTabButton(1, AppString.requests,
                          messagesController.selectedIndex.value == 1);
                    }),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => messagesController.selectedIndex.value == 0
                  ? _buildMessageTabContent(context)
                  : _buildRequestsTabContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String text, bool isSelected) {
    return InkWell(
      onTap: () => messagesController.selectTab(index),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.secondaryColor
              : AppColor.cardBackgroundColor,
          borderRadius: BorderRadius.circular(AppSize.appSize6),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppSize.appSize14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontFamily:
                  isSelected ? AppFont.appFontSemiBold : AppFont.appFontRegular,
              color: isSelected
                  ? AppColor.backgroundColor
                  : AppColor.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageTabContent(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messagesController.messageProfilesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSize.appSize8),
          child: ListTile(
            onTap: () {
              Get.toNamed(AppRoutes.messagesChatView);
            },
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: SizedBox(
              width: AppSize.appSize50,
              height: AppSize.appSize50,
              child: Center(
                child: Image.asset(
                  messagesController.messageProfilesList[index],
                  width: messagesController.messageProfilesWidthList[index],
                ),
              ),
            ),
            title: Text(
              messagesController.messageProfileNamesList[index],
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  messagesController.messagesList[index],
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: (index == 0 || index == 1 || index == 2)
                        ? FontWeight.w600
                        : FontWeight.w400,
                    fontFamily: (index == 0 || index == 1 || index == 2)
                        ? AppFont.appFontSemiBold
                        : AppFont.appFontRegular,
                    color: (index == 0 || index == 1 || index == 2)
                        ? AppColor.secondaryColor
                        : AppColor.text2Color,
                  ),
                ),
                if (index == 0 ||
                    index == 1 ||
                    index == 2 ||
                    index == 3 ||
                    index == 4) ...[
                  Container(
                    width: AppSize.appSize4,
                    height: AppSize.appSize4,
                    margin: const EdgeInsets.only(
                        left: AppSize.appSize8,
                        right: AppSize.appSize8,
                        top: AppSize.appSize6),
                    decoration: const BoxDecoration(
                      color: AppColor.text2Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize3),
                    child: Text(
                      messagesController.messageTimingsList[index],
                      style: const TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            trailing: (index == 0 || index == 1)
                ? Container(
                    width: AppSize.appSize6,
                    height: AppSize.appSize6,
                    margin: const EdgeInsets.only(
                        left: AppSize.appSize8,
                        right: AppSize.appSize8,
                        top: AppSize.appSize6),
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _buildRequestsTabContent(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: AppSize.size2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSize.appSize8),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: SizedBox(
              width: AppSize.appSize50,
              height: AppSize.appSize50,
              child: Center(
                child: Image.asset(
                  messagesController.messageProfilesList[index],
                  width: messagesController.messageProfilesWidthList[index],
                ),
              ),
            ),
            title: Text(
              messagesController.messageProfileNamesList[index],
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  messagesController.messagesList[index],
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: (index == 0 || index == 1 || index == 2)
                        ? FontWeight.w600
                        : FontWeight.w400,
                    fontFamily: (index == 0 || index == 1 || index == 2)
                        ? AppFont.appFontSemiBold
                        : AppFont.appFontRegular,
                    color: (index == 0 || index == 1 || index == 2)
                        ? AppColor.secondaryColor
                        : AppColor.text2Color,
                  ),
                ),
                if (index == 0 ||
                    index == 1 ||
                    index == 2 ||
                    index == 3 ||
                    index == 4) ...[
                  Container(
                    width: AppSize.appSize4,
                    height: AppSize.appSize4,
                    margin: const EdgeInsets.only(
                        left: AppSize.appSize8,
                        right: AppSize.appSize8,
                        top: AppSize.appSize6),
                    decoration: const BoxDecoration(
                      color: AppColor.text2Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize3),
                    child: Text(
                      messagesController.messageTimingsList[index],
                      style: const TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            trailing: (index == 0 || index == 1)
                ? Container(
                    width: AppSize.appSize6,
                    height: AppSize.appSize6,
                    margin: const EdgeInsets.only(
                        left: AppSize.appSize8,
                        right: AppSize.appSize8,
                        top: AppSize.appSize6),
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
