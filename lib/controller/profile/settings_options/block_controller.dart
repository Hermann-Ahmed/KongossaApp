import 'package:get/get.dart';
import '../../../config/app_image.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class BlockController extends GetxController {
  RxList<String> blockIDImageList = [
    AppImage.story2,
    AppImage.profile7,
    AppImage.profile8,
    AppImage.profile10,
  ].obs;

  RxList<String> blockIDList = [
    AppString.eleanorPenaID,
    AppString.jenuuuWilsonID,
    AppString.marvinID,
    AppString.wade10ID,
  ].obs;

  RxList<String> blockUsernameList = [
    AppString.eleanorPena,
    AppString.jenuuuWilson,
    AppString.marvinCo,
    AppString.wadeWarren,
  ].obs;

  RxList<double> blockImageWidthList = [
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize52,
    AppSize.appSize52,
  ].obs;
}