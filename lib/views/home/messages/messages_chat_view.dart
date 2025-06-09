// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/controller/home/message_chat_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';
import 'package:kongossa/views/widget/home/messages/share_view_dialog.dart';

import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class MessagesChatView extends StatelessWidget {
  MessagesChatView({Key? key}) : super(key: key);

  MessageChatController messageChatController =
      Get.put(MessageChatController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        messageChatController.messageFocusNode.unfocus();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _appBar(context),
        body: _body(context),
      ),
    );
  }

  //Messages Chat content
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
            messageChatController.typeMessageController.clear();
            messageChatController.messageFocusNode.unfocus();
          },
          child: Image.asset(
            languageController.selectedLanguageIndex.value == AppSize.size2
                ? AppIcon.backRight
                : AppIcon.back,
          ),
        ),
      ),
      leadingWidth: AppSize.appSize44,
      title: Padding(
        padding: const EdgeInsets.only(top: AppSize.appSize5),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: AppSize.appSize12,
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize12
                    : AppSize.appSize0,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.storyFullView);
                },
                child: Image.asset(
                  AppImage.story2,
                  width: AppSize.appSize38,
                ),
              ),
            ),
            const Column(
              children: [
                Text(
                  AppString.eleanorPena,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.secondaryColor,
                  ),
                ),
                Text(
                  AppString.eleanorPenaID,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.text1Color,
                  ),
                ),
              ],
            ),
          ],
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.callView);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppSize.appSize3,
                    right: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize0
                        : AppSize.appSize18,
                    left: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize18
                        : AppSize.appSize0,
                  ),
                  child: Image.asset(
                    AppIcon.call,
                    width: AppSize.appSize23,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.videoCallRingingView);
                },
                child: Image.asset(
                  AppIcon.video,
                  width: AppSize.appSize24,
                ),
              ),
            ],
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
          right: AppSize.appSize20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customChatMessage(
                    kIsWeb
                        ? AppSize.appSize400
                        : MediaQuery.of(context).size.width *
                            AppSize.appSizePoint73,
                    AppColor.chatColor,
                    const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.appSize12),
                      topRight: Radius.circular(AppSize.appSize12),
                      bottomRight: Radius.circular(AppSize.appSize12),
                    ),
                    AppString.loremString2,
                    AppString.pm1,
                    AppColor.text1Color,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize4),
                    child: _customChatMessage(
                      kIsWeb
                          ? AppSize.appSize355
                          : MediaQuery.of(context).size.width *
                              AppSize.appSizePoint50,
                      AppColor.chatColor,
                      const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.appSize12),
                        topRight: Radius.circular(AppSize.appSize12),
                        bottomRight: Radius.circular(AppSize.appSize12),
                      ),
                      AppString.loremString6,
                      AppString.pm1,
                      AppColor.text1Color,
                    ),
                  ),
                  Align(
                    alignment: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSize.appSize12),
                      child: _customChatMessage(
                        kIsWeb
                            ? AppSize.appSize400
                            : MediaQuery.of(context).size.width *
                                AppSize.appSizePoint73,
                        AppColor.primaryColor,
                        const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.appSize12),
                          topRight: Radius.circular(AppSize.appSize12),
                          bottomLeft: Radius.circular(AppSize.appSize12),
                        ),
                        AppString.loremString2,
                        AppString.pm1,
                        AppColor.text3Color,
                      ),
                    ),
                  ),
                  Align(
                    alignment: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSize.appSize4),
                      child: _customChatMessage(
                        kIsWeb
                            ? AppSize.appSize400
                            : MediaQuery.of(context).size.width *
                                AppSize.appSizePoint73,
                        AppColor.primaryColor,
                        const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.appSize12),
                          topRight: Radius.circular(AppSize.appSize12),
                          bottomLeft: Radius.circular(AppSize.appSize12),
                        ),
                        AppString.loremString2,
                        AppString.pm1,
                        AppColor.text3Color,
                      ),
                    ),
                  ),
                  Align(
                    alignment: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSize.appSize4),
                      child: _customChatMessage(
                        kIsWeb
                            ? AppSize.appSize400
                            : MediaQuery.of(context).size.width *
                                AppSize.appSizePoint80,
                        AppColor.primaryColor,
                        const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.appSize12),
                          topRight: Radius.circular(AppSize.appSize12),
                          bottomLeft: Radius.circular(AppSize.appSize12),
                        ),
                        AppString.loremString7,
                        AppString.pm1,
                        AppColor.text3Color,
                      ),
                    ),
                  ),
                  Align(
                    alignment: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      width: kIsWeb
                          ? AppSize.appSize270
                          : MediaQuery.of(context).size.width *
                              AppSize.appSizePoint70,
                      margin: const EdgeInsets.only(top: AppSize.appSize4),
                      decoration: const BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppSize.appSize12),
                          topRight: Radius.circular(AppSize.appSize12),
                          bottomLeft: Radius.circular(AppSize.appSize12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: AppSize.appSize8,
                          right: AppSize.appSize8,
                          top: AppSize.appSize8,
                          bottom: AppSize.appSize10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppImage.chatImage1,
                              width: AppSize.appSize120,
                            ),
                            Image.asset(
                              AppImage.chatImage2,
                              width: AppSize.appSize120,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.appSize12),
                    child: _customChatMessage(
                      kIsWeb
                          ? AppSize.appSize355
                          : MediaQuery.of(context).size.width *
                              AppSize.appSizePoint50,
                      AppColor.chatColor,
                      const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.appSize12),
                        topRight: Radius.circular(AppSize.appSize12),
                        bottomRight: Radius.circular(AppSize.appSize12),
                      ),
                      AppString.loremString6,
                      AppString.pm1,
                      AppColor.text1Color,
                    ),
                  ),
                  Align(
                    alignment: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSize.appSize12),
                      child: _customChatMessage(
                        kIsWeb
                            ? AppSize.appSize355
                            : MediaQuery.of(context).size.width *
                                AppSize.appSizePoint50,
                        AppColor.primaryColor,
                        const BorderRadius.only(
                          topLeft: Radius.circular(AppSize.appSize12),
                          topRight: Radius.circular(AppSize.appSize12),
                          bottomLeft: Radius.circular(AppSize.appSize12),
                        ),
                        AppString.loremString6,
                        AppString.pm1,
                        AppColor.text3Color,
                      ),
                    ),
                  ),
                  Container(
                    width: kIsWeb
                        ? AppSize.appSize54
                        : MediaQuery.of(context).size.width *
                            AppSize.appSizePoint13,
                    margin: const EdgeInsets.only(top: AppSize.appSize12),
                    decoration: const BoxDecoration(
                      color: AppColor.chatColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSize.appSize12),
                        topRight: Radius.circular(AppSize.appSize12),
                        bottomRight: Radius.circular(AppSize.appSize12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: AppSize.appSize10,
                        right: AppSize.appSize10,
                        top: AppSize.appSize12,
                        bottom: AppSize.appSize12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: AppSize.appSize8,
                            height: AppSize.appSize8,
                            decoration: const BoxDecoration(
                              color: AppColor.text1Color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: AppSize.appSize8,
                            height: AppSize.appSize8,
                            decoration: BoxDecoration(
                              color: AppColor.text1Color
                                  .withOpacity(AppSize.appSizePoint6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: AppSize.appSize8,
                            height: AppSize.appSize8,
                            decoration: BoxDecoration(
                              color: AppColor.text1Color
                                  .withOpacity(AppSize.appSizePoint4),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: AppSize.appSize20, top: AppSize.appSize5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize10
                          : AppSize.appSize0,
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize0
                          : AppSize.appSize10,
                    ),
                    height: AppSize.appSize48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.appSize12),
                      color: AppColor.cardBackgroundColor,
                      border: Border.all(
                        color: AppColor.borderColor,
                      ),
                    ),
                    child: TextFormField(
                      controller: messageChatController.typeMessageController,
                      cursorColor: AppColor.secondaryColor,
                      style: const TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontSemiBold,
                        color: AppColor.secondaryColor,
                      ),
                      focusNode: messageChatController.messageFocusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          bottom: AppSize.appSize1,
                        ),
                        hintText: AppString.typeMessage,
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
                          padding: const EdgeInsets.only(
                            top: AppSize.appSize2,
                            right: AppSize.appSize14,
                            left: AppSize.appSize14,
                          ),
                          child: Image.asset(
                            AppIcon.emoji,
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          maxWidth: AppSize.appSize46,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize10
                                : AppSize.appSize0,
                            right: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize0
                                : AppSize.appSize10,
                          ),
                          child: SizedBox(
                            width: AppSize.appSize70,
                            height: AppSize.appSize18,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: languageController
                                                .selectedLanguageIndex.value ==
                                            AppSize.size2
                                        ? AppSize.appSize12
                                        : AppSize.appSize0,
                                    right: languageController
                                                .selectedLanguageIndex.value ==
                                            AppSize.size2
                                        ? AppSize.appSize0
                                        : AppSize.appSize12,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ShareViewDialog();
                                        },
                                      );
                                      messageChatController.messageFocusNode
                                          .unfocus();
                                      messageChatController
                                          .typeMessageController
                                          .clear();
                                    },
                                    child: Image.asset(
                                      AppIcon.clip,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.cameraView);
                                    messageChatController.messageFocusNode
                                        .unfocus();
                                    messageChatController.typeMessageController
                                        .clear();
                                  },
                                  child: Image.asset(
                                    AppIcon.camera,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          maxWidth: AppSize.appSize64,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: AppSize.appSize48,
                  width: AppSize.appSize48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.appSize12),
                    color: AppColor.primaryColor,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppIcon.send,
                      width: AppSize.appSize20,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _customChatMessage(
      double width,
      Color messageColor,
      BorderRadiusGeometry borderRadius,
      String text1,
      String text2,
      Color text2Color) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: width,
          decoration: BoxDecoration(
            color: messageColor,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSize.appSize8,
              right: AppSize.appSize8,
              top: AppSize.appSize8,
              bottom: AppSize.appSize10,
            ),
            child: Text(
              text1,
              textAlign: languageController.selectedLanguageIndex.value ==
                      AppSize.size2
                  ? TextAlign.right
                  : TextAlign.left,
              style: const TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppSize.appSize6,
            right: AppSize.appSize10,
          ),
          child: Text(
            text2,
            style: TextStyle(
              fontSize: AppSize.appSize12,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.appFontRegular,
              color: text2Color,
            ),
          ),
        ),
      ],
    );
  }
}
