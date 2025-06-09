import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/app_image.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';

class SearchIDController extends GetxController {
  TextEditingController searchFieldController = TextEditingController();

  RxList<String> searchIDImageList = [
    AppImage.story2,
    AppImage.profile5,
    AppImage.comment5,
    AppImage.profile6,
    AppImage.profile7,
    AppImage.profile8,
  ].obs;

  RxList<String> searchIDList = [
    AppString.eleanorPenaID,
    AppString.rr00ID,
    AppString.deVonID,
    AppString.foxRoboertID,
    AppString.jenuuuWilsonID,
    AppString.marvinID,
  ].obs;

  RxList<String> searchUsernameList = [
    AppString.eleanorPena,
    AppString.ronaldRichards,
    AppString.devonLane,
    AppString.robertFox,
    AppString.jennyWilson,
    AppString.marvin,
  ].obs;

  RxList<double> searchImageWidthList = [
    AppSize.appSize52,
    AppSize.appSize46,
    AppSize.appSize46,
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize52,
  ].obs;
}