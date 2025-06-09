import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';

class MessagesController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();

  RxInt selectedIndex = 0.obs;

  void selectTab(int index) {
    selectedIndex.value = index;
  }

  RxList<String> messageProfilesList = [
    AppImage.story2,
    AppImage.profile5,
    AppImage.profile8,
    AppImage.profile6,
    AppImage.profile7,
    AppImage.comment5,
  ].obs;

  RxList<double> messageProfilesWidthList = [
    AppSize.appSize52,
    AppSize.appSize46,
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize46,
  ].obs;

  RxList<String> messageProfileNamesList = [
    AppString.eleanorPena,
    AppString.rr,
    AppString.marvinCo,
    AppString.foxRobert,
    AppString.jenuuuWilson,
    AppString.devon,
  ].obs;

  RxList<String> messagesList = [
    AppString.sendByHelloDeep,
    AppString.sendByHelloDeep,
    AppString.sendByHello,
    AppString.sendByFunZone,
    AppString.sendByHelloDeep,
    AppString.seen23HAgo,
  ].obs;

  RxList<String> messageTimingsList = [
    AppString.minute2,
    AppString.hours3,
    AppString.hours2,
    AppString.hours2,
    AppString.hours4,
  ].obs;
}
