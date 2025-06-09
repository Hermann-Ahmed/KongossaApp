import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/bottom_bar/bottom_bar_controller.dart';

import '../../model/highlight_model.dart';

BottomBarController bottomBarController = Get.put(BottomBarController());

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  RxBool isFollow = false.obs;
  RxBool isLiked = false.obs;
  RxInt selectedTabIndex = 0.obs;
  RxInt isSelected = (-1).obs;
  RxList<HighlightItem> highlights = <HighlightItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      initialIndex: AppSize.size0,
      length: AppSize.size4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
    isSelected.value = -1;
  }

  void toggleFollow() {
    isFollow.value = !isFollow.value;
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  void selectItem(int index) {
    isSelected.value = index;
  }

  RxList<String> postsList = [
    AppString.post1,
    AppString.post2,
    AppString.post3,
    AppString.post4,
    AppString.post5,
    AppString.post6,
    AppString.post7,
    AppString.post8,
    AppString.post9,
    AppString.post1,
    AppString.post2,
    AppString.post3,
    AppString.post4,
    AppString.post5,
    AppString.post6,
    AppString.post7,
    AppString.post8,
    AppString.post9,
  ].obs;

  RxList<String> reelsList = [
    AppString.reel1,
    AppString.reel2,
    AppString.reel3,
    AppString.reel4,
    AppString.reel5,
    AppString.reel6,
    AppString.reel7,
    AppString.reel8,
    AppString.reel9,
  ].obs;

  RxList<String> reelsViewList = [
    AppString.reelView500,
    AppString.reelView500k,
    AppString.reelView100k,
    AppString.reelView5and5k,
    AppString.reelView20k,
    AppString.reelView389,
    AppString.reelView1m,
    AppString.reelView2and5m,
    AppString.reelView78,
  ].obs;

  RxList<String> profileActionsList = [
    AppString.yourActivity,
    AppString.qrCode,
    AppString.saved,
    AppString.closeFriends,
    AppString.settings,
  ].obs;
}
