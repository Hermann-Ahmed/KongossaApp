import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayController extends GetxController {
  VideoPlayerController? videoPlayerController;
  RxBool isInitialised = false.obs;
  RxBool isVideoPlaying = false.obs;
  RxBool isFollow = false.obs;
  RxBool isLiked = false.obs;
  RxBool isExpanded = false.obs;

  PageController pageController = PageController();

  RxInt currentReelIndex = 0.obs;
  RxBool showHeartIcon = false.obs;

  VideoPlayerController? get controller => videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    // initializeVideoPlayer();
  }

  Future<void> openCamera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {}
  }

  // void initializeVideoPlayer() {
  //   videoPlayerController = VideoPlayerController.asset(
  //     "assets/videos/reelVideo.mp4",
  //   );
  //
  //   controller?.initialize().then((_) {
  //     isInitialised.value = true;
  //     controller?.setLooping(true);
  //     controller?.play();
  //     controller?.addListener(() {
  //       if (videoPlayerController!.value.position ==
  //           videoPlayerController!.value.duration) {
  //         videoPlayerController!.seekTo(Duration.zero);
  //         videoPlayerController!.play();
  //       }
  //     });
  //   });
  // }

  void toggleFollow() {
    isFollow.value = !isFollow.value;
  }

  void toggleLike() {
    bool wasLiked = isLiked.value;
    isLiked.value = !isLiked.value;

    if (isLiked.value && !wasLiked) {
      showHeartIcon.value = true;

      Future.delayed(const Duration(seconds: AppSize.size2), () {
        showHeartIcon.value = false;
      });
    }
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void onPageChanged(int index) {
    if (index != currentReelIndex.value) {
      // stopVideoPlayback();
      // loadVideoForReelIndex(index);
      currentReelIndex.value = index;
    }
  }

  // void stopVideoPlayback() {
  //   if (controller!.value.isPlaying) {
  //     controller?.pause();
  //   }
  //   controller?.seekTo(Duration.zero);
  // }
  //
  // void loadVideoForReelIndex(int index) {
  //   videoPlayerController = VideoPlayerController.asset(
  //     "assets/videos/reelVideo.mp4",
  //   );
  //
  //   controller?.initialize().then((_) {
  //     isInitialised.value = true;
  //     controller?.setLooping(true);
  //     controller?.play();
  //     controller?.addListener(() {
  //       if (videoPlayerController!.value.position ==
  //           videoPlayerController!.value.duration) {
  //         videoPlayerController!.seekTo(Duration.zero);
  //         videoPlayerController!.play();
  //       }
  //     });
  //   });
  // }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
