// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/app_color.dart';

enum CaptureMode { photo, video }

class CreateReelController extends GetxController {
  CameraController? controller;
  RxBool isCameraInitialized = false.obs;
  RxBool useFrontCamera = true.obs;
  RxBool isSwapping = false.obs;
  Rx<CaptureMode> captureMode = CaptureMode.photo.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
    swapCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();

    if (controller != null && cameras.isNotEmpty && cameras[0].lensDirection == _currentCameraDirection()) {
      return;
    }

    controller?.dispose();

    if (cameras.isNotEmpty) {
      controller = CameraController(
        cameras.firstWhere((camera) => camera.lensDirection == _currentCameraDirection()),
        ResolutionPreset.medium,
      );

      try {
        await controller?.initialize();
        isCameraInitialized.value = true;
      } catch (e) {
        isCameraInitialized.value = false;
      }
    } else {
      isCameraInitialized.value = false;
    }
  }

  Future<void> captureImage() async {
    try {
      if (captureMode.value == CaptureMode.photo) {
        final XFile? imageFile = await controller?.takePicture();
        print("Image captured: ${imageFile?.path}");
      } else if (captureMode.value == CaptureMode.video) {
        if (controller?.value.isRecordingVideo == true) {
          final XFile? videoFile = await controller?.stopVideoRecording();
          print("Video recorded: ${videoFile?.path}");
        } else {
          await controller?.startVideoRecording();
        }
      }
    } catch (e) {
      print("Error capturing image/video: $e");
    }
  }

  void setCaptureMode(CaptureMode mode) {
    captureMode.value = mode;
    update();
  }

  void toggleCaptureMode() {
    captureMode.value = captureMode.value == CaptureMode.photo
        ? CaptureMode.video
        : CaptureMode.photo;
    update();
  }

  Future<void> swapCamera() async {
    isSwapping.value = true;
    if (controller != null) {
      await controller?.dispose();
    }

    useFrontCamera.value = !useFrontCamera.value;

    if (!isCameraInitialized.value) {
      await initializeCamera();
    }

    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      controller = CameraController(
        cameras.firstWhere((camera) => camera.lensDirection == _currentCameraDirection()),
        ResolutionPreset.medium,
      );

      try {
        await controller?.initialize();
        isCameraInitialized.value = true;
      } catch (e) {
        isCameraInitialized.value = false;
      }
    } else {
      isCameraInitialized.value = false;
    }
    isSwapping.value = false;
    update();
  }

  CameraLensDirection _currentCameraDirection() {
    return useFrontCamera.value ? CameraLensDirection.front : CameraLensDirection.back;
  }

  Future<void> openGallery() async {
    try {
      final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        print("Image selected from gallery: ${imageFile.path}");
      } else {
        print("No image selected from gallery");
      }
    } catch (e) {
      print("Error opening gallery: $e");
    }
  }


  @override
  void dispose() {
    super.dispose();
    if(controller != null) {

      controller?.dispose();
    }
  }

  Widget buildCameraPreview() {
    if (isSwapping.value) {
      return Container(color: AppColor.backgroundColor);
    } else {
      return Obx(() {
        return isCameraInitialized.value ? CameraPreview(controller!) : Container(color: AppColor.backgroundColor);
      });
    }
  }
}