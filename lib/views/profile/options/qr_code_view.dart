// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import '../../../config/app_color.dart';
import '../../../config/app_font.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../../config/app_string.dart';

class QRCodeView extends StatelessWidget {
  QRCodeView({Key? key}) : super(key: key);

  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(),
      body: _body(context),
    );
  }

  //QR Code content
  _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      scrolledUnderElevation: AppSize.appSize0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(
            top: AppSize.appSize12, left: AppSize.appSize6),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize12
                    : AppSize.appSize0,
                right: languageController.selectedLanguageIndex.value ==
                        AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize12,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppIcon.backRight
                      : AppIcon.back,
                  width: AppSize.appSize24,
                ),
              ),
            ),
            const Text(
              AppString.qrCode,
              style: TextStyle(
                fontSize: AppSize.appSize20,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize20
                    : AppSize.appSize0,
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize20,
            top: AppSize.appSize12,
          ),
          child: GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                msg: AppString.qrScanned,
                backgroundColor: AppColor.cardBackgroundColor,
                fontSize: AppSize.appSize14,
                textColor: AppColor.secondaryColor,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            },
            child: GestureDetector(
              // onTap: _scanBarcode,
              child: Image.asset(
                AppIcon.scan,
                width: AppSize.appSize24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppSize.appSize38, right: AppSize.appSize38),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: AppSize.appSize350,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: AppSize.appSize32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.appSize12),
              color: AppColor.cardBackgroundColor,
            ),
            child: Center(
              child: Image.asset(
                AppIcon.qr,
                width: AppSize.appSize250,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: AppString.profileShared,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: AppSize.size1,
                      backgroundColor: AppColor.cardBackgroundColor,
                      textColor: AppColor.secondaryColor,
                      fontSize: AppSize.appSize14,
                    );
                  },
                  child: Container(
                    height: AppSize.appSize64,
                    decoration: BoxDecoration(
                      color: AppColor.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(AppSize.appSize12),
                    ),
                    child: const Center(
                      child: Text(
                        AppString.shareProfile,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSize.appSize24),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: AppString.linkCopied,
                      backgroundColor: AppColor.cardBackgroundColor,
                      fontSize: AppSize.appSize14,
                      textColor: AppColor.secondaryColor,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  },
                  child: Container(
                    height: AppSize.appSize64,
                    decoration: BoxDecoration(
                      color: AppColor.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(AppSize.appSize12),
                    ),
                    child: const Center(
                      child: Text(
                        AppString.copyLink,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Future<void> _scanBarcode() async {
  //   String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
  //     AppString.colorString,
  //     AppString.cancelString,
  //     true,
  //     ScanMode.BARCODE,
  //   );

  //   print(barcodeScanResult);
  // }
}
