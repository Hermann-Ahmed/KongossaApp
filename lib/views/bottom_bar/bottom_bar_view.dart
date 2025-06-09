// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/controller/bottom_bar/bottom_bar_controller.dart';

class BottomBarView extends StatelessWidget {
  BottomBarView({Key? key}) : super(key: key);

  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomTheme.bottomNavBarTheme,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(context),
        bottomNavigationBar: _bottomBar(context),
      ),
    );
  }

  //Bottom Bar content
  _body(BuildContext context) {
    return Obx(() => PageView.builder(
          itemCount: bottomBarController.pages.length,
          controller: bottomBarController.pageController,
          onPageChanged: (index) {
            bottomBarController.changeSelectedIndex(context, index);
          },
          itemBuilder: (context, index) {
            return bottomBarController.pages[index];
          },
        ));
  }

  _bottomBar(BuildContext context) {
    return Obx(() => SizedBox(
          height: kIsWeb
              ? AppSize.appSize62
              : Platform.isIOS
                  ? AppSize.appSize90
                  : AppSize.appSize62,
          child: BottomNavigationBar(
            iconSize: AppSize.appSize22,
            backgroundColor: AppColor.cardBackgroundColor,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: bottomBarController.selectedIndex.value,
            onTap: (index) {
              bottomBarController.changeSelectedIndex(context, index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  bottomBarController.selectedIndex.value == 0
                      ? AppIcon.homeFillIcon
                      : AppIcon.homeIcon,
                  width: AppSize.appSize22,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  bottomBarController.selectedIndex.value == 1
                      ? AppIcon.notificationFillIcon
                      : AppIcon.notificationIcon,
                  width: AppSize.appSize22,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcon.postIcon,
                  width: AppSize.appSize22,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  bottomBarController.selectedIndex.value == 3
                      ? AppIcon.reelFillIcon
                      : AppIcon.reelIcon,
                  width: AppSize.appSize22,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  bottomBarController.selectedIndex.value == 4
                      ? AppIcon.profileFillIcon
                      : AppIcon.profileIcon,
                  width: AppSize.appSize22,
                ),
                label: '',
              ),
            ],
          ),
        ));
  }
}

class CustomTheme {
  static ThemeData bottomNavBarTheme = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
