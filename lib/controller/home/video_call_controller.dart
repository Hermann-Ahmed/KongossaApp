import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';

class VideoCallController extends GetxController {
  RxList<String> videoCallList = [
    AppImage.videoCall3,
    AppImage.videoCall4,
    AppImage.videoCall5,
    AppImage.videoCall6,
  ].obs;
}
