// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_font.dart';
import '../config/app_size.dart';

class AppButton extends StatelessWidget {
  void Function() onPressed;
  double? height;
  double? width;
  Color? backgroundColor;
  BorderSide? side;
  String text;
  Color? textColor;
  EdgeInsetsGeometry? margin;
  AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height,
    this.width,
    this.textColor,
    this.backgroundColor,
    this.side,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? AppSize.appSize48,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor.transparentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.appSize66),
            side: side ?? BorderSide.none,
          ),
          elevation: AppSize.appSize0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: AppSize.appSize16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFont.appFontSemiBold,
            color: textColor ?? AppColor.secondaryColor,
          ),
        ),
      ),
    );
  }
}
