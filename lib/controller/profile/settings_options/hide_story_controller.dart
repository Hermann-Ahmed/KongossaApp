import 'package:get/get.dart';
import '../../../config/app_image.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class HideStoryController extends GetxController {
  RxList<String> hideIDImageList = [
    AppImage.story2,
    AppImage.profile7,
    AppImage.profile8,
    AppImage.profile10,
  ].obs;

  RxList<String> hideIDList = [
    AppString.eleanorPenaID,
    AppString.jenuuuWilsonID,
    AppString.marvinID,
    AppString.wade10ID,
  ].obs;

  RxList<String> hideUsernameList = [
    AppString.eleanorPena,
    AppString.jenuuuWilson,
    AppString.marvinCo,
    AppString.wadeWarren,
  ].obs;

  RxList<double> hideImageWidthList = [
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize52,
  ].obs;
}