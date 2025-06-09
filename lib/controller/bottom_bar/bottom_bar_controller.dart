import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/views/home/home_view.dart';
import 'package:kongossa/views/notification/notifications_view.dart';
import 'package:kongossa/views/profile/profile_view.dart';
import 'package:kongossa/views/reels/reels_view.dart';
import 'package:kongossa/views/widget/new_post/new_post_options_bottom_sheet.dart';

class BottomBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  void changeSelectedIndex(BuildContext context, int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 2) {
      selectedIndex.value = 0;
      newPostOptionsBottomSheet(context);
    }
    pageController.jumpToPage(selectedIndex.value);
    update();
  }

  RxList<Widget> pages = [
    HomeView(),
    NotificationsView(),
    Container(),
    ReelsView(),
    ProfileView(),
  ].obs;
}
