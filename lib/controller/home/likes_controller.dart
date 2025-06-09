import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';

class LikesController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxList<bool> isFollowList =
      List.generate(AppSize.size8, (index) => false).obs;

  void toggleFollow(int index) {
    isFollowList[index] = !isFollowList[index];
  }

  RxList<String> likesIDImageList = [
    AppImage.story2,
    AppImage.profile5,
    AppImage.comment5,
    AppImage.profile6,
    AppImage.profile7,
    AppImage.profile8,
    AppImage.profile9,
    AppImage.profile10,
  ].obs;

  RxList<String> likesIDList = [
    AppString.eleanorPenaID,
    AppString.rr00ID,
    AppString.deVonID,
    AppString.foxRoboertID,
    AppString.jenuuuWilsonID,
    AppString.marvinID,
    AppString.estherHowardID,
    AppString.wade10ID,
  ].obs;

  RxList<String> likeUsernameList = [
    AppString.eleanorPena,
    AppString.ronaldRichards,
    AppString.devonLane,
    AppString.robertFox,
    AppString.jennyWilson,
    AppString.marvin,
    AppString.estherHoward,
    AppString.wadeWarren,
  ].obs;

  RxList<double> likeImageWidthList = [
    AppSize.appSize52,
    AppSize.appSize46,
    AppSize.appSize46,
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize46,
    AppSize.appSize52,
  ].obs;

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }
}
