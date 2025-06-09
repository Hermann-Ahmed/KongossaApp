import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';

class HomeController extends GetxController {
  Rx<int> selectedLabelIndex = Rx<int>(0);
  RxDouble progress = 0.0.obs;
  RxBool isLiked = false.obs;
  RxBool isLiked1 = false.obs;
  RxBool isLiked2 = false.obs;
  RxBool isLiked3 = false.obs;
  RxBool isLiked4 = false.obs;
  RxBool isLiked5 = false.obs;
  RxBool isLiked6 = false.obs;

  void startAnimation() async {
    await Future.delayed(const Duration(seconds: AppSize.size2));
    Get.back();
  }

  HomeController() {
    selectLabel(0);
  }

  bool isLabelSelected(int index) {
    return selectedLabelIndex.value == index;
  }

  void selectLabel(int index) {
    selectedLabelIndex.value = index;
    update();
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void toggleLike1() {
    isLiked1.value = !isLiked1.value;
  }

  void toggleLike2() {
    isLiked2.value = !isLiked2.value;
  }

  void toggleLike3() {
    isLiked3.value = !isLiked3.value;
  }

  void toggleLike4() {
    isLiked4.value = !isLiked4.value;
  }

  void toggleLike5() {
    isLiked5.value = !isLiked5.value;
  }

  void toggleLike6() {
    isLiked6.value = !isLiked6.value;
  }

  RxList<String> storyList = [
    AppImage.myStory,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
  ].obs;

  RxList<String> storyIDList = [
    AppString.yourStory,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
  ].obs;

  RxList<String> labelsList = [
    AppString.trending,
    AppString.forMe,
    AppString.following,
    AppString.recommend,
  ].obs;

  RxList<String> reelsList = [
    AppImage.reel1,
    AppImage.reel2,
    AppImage.reel1,
    AppImage.reel2,
    AppImage.reel1,
    AppImage.reel2,
    AppImage.reel1,
    AppImage.reel2,
  ].obs;
}
