import 'package:get/get.dart';

class ReelCaptureController extends GetxController {
  // VideoPlayerController? videoPlayerController;
  // ChewieController? chewieController;

  @override
  void onInit() {
    super.onInit();
    // videoPlayerController = VideoPlayerController.asset(
    //   AppString.reelVideoLink,
    // );
    //
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController!,
    //   autoPlay: true,
    //   looping: true,
    //   showControls: false,
    //   allowFullScreen: true,
    // );
    //
    // chewieController?.enterFullScreen();
  }

  @override
  void dispose() {
    // videoPlayerController?.dispose();
    // chewieController?.dispose();
    super.dispose();
  }
}