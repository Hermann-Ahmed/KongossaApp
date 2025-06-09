// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/home/message_camera_controller.dart';

import '../../../config/app_icon.dart';

class CameraView extends StatelessWidget {
  CameraView({Key? key}) : super(key: key);

  MessageCameraController messageCameraController =
      Get.put(MessageCameraController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Obx(() {
                    return messageCameraController.isCameraInitialized.value
                        ? messageCameraController.buildCameraPreview()
                        : Container(color: AppColor.backgroundColor);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppSize.appSize20, top: AppSize.appSize44),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      AppIcon.back,
                      width: AppSize.appSize24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: AppSize.appSize140,
            padding: const EdgeInsets.only(
                left: AppSize.appSize20,
                right: AppSize.appSize20,
                top: AppSize.appSize24),
            color: AppColor.backgroundColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        messageCameraController.openGallery();
                      },
                      child: Image.asset(
                        AppImage.gallery,
                        width: AppSize.appSize48,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        messageCameraController.toggleCaptureMode();
                      },
                      child: Obx(() => Image.asset(
                            messageCameraController.captureMode.value ==
                                    CaptureMode.video
                                ? AppImage.videoButton
                                : AppImage.cameraTouch,
                            width: AppSize.appSize62,
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        messageCameraController.swapCamera();
                      },
                      child: Image.asset(
                        AppImage.cameraSwap,
                        width: AppSize.appSize48,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: AppSize.appSize12),
                        child: GestureDetector(
                          onTap: () {
                            messageCameraController
                                .setCaptureMode(CaptureMode.photo);
                          },
                          child: Obx(() => Text(
                                AppString.photo,
                                style:
                                    messageCameraController.captureMode.value ==
                                            CaptureMode.photo
                                        ? _selectedTextStyle
                                        : _unselectedTextStyle,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          messageCameraController
                              .setCaptureMode(CaptureMode.video);
                        },
                        child: Obx(() => Text(
                              AppString.video,
                              style:
                                  messageCameraController.captureMode.value ==
                                          CaptureMode.video
                                      ? _selectedTextStyle
                                      : _unselectedTextStyle,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final TextStyle _selectedTextStyle = const TextStyle(
    fontSize: AppSize.appSize14,
    fontWeight: FontWeight.w600,
    fontFamily: AppFont.appFontRegular,
    color: AppColor.secondaryColor,
  );

  final TextStyle _unselectedTextStyle = const TextStyle(
    fontSize: AppSize.appSize14,
    fontWeight: FontWeight.w400,
    fontFamily: AppFont.appFontRegular,
    color: AppColor.text1Color,
  );
}
