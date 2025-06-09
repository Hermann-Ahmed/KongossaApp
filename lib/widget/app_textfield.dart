// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_color.dart';
import '../config/app_font.dart';
import '../config/app_size.dart';

class AppTextField extends StatelessWidget {
  TextInputType? keyboardType;
  TextEditingController controller;
  Color? cursorColor;
  String labelText;
  bool? obscureText;
  bool? readOnly;
  Color? fillColor;
  FocusNode? focusNode;
  TextInputAction? textInputAction;
  void Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;
  InputBorder? border;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  Widget? suffixIcon;
  BoxConstraints? suffixIconConstraints;
  Color? suffixIconColor;
  AppTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.cursorColor,
    this.keyboardType,
    this.obscureText,
    this.readOnly,
    this.fillColor,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.inputFormatters,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.suffixIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.appSize64,
      decoration: BoxDecoration(
        color: AppColor.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSize.appSize12),
        border: Border.all(color: AppColor.borderColor, width: AppSize.appSizePoint7),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        style: const TextStyle(
          fontSize: AppSize.appSize16,
          fontWeight: FontWeight.w600,
          fontFamily: AppFont.appFontSemiBold,
          color: AppColor.secondaryColor,
        ),
        cursorColor: cursorColor,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        textInputAction: textInputAction,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: AppSize.appSize16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFont.appFontSemiBold,
            color: AppColor.text1Color,
          ),
          floatingLabelStyle: const TextStyle(
            fontSize: AppSize.appSize14,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontRegular,
            color: AppColor.text1Color,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.only(
            top: AppSize.appSize12,
            left: AppSize.appSize14,
            right: AppSize.appSize22,
            bottom: AppSize.appSize12,
          ),
          isDense: true,
          filled: true,
          fillColor: fillColor,
          border: border ?? UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppSize.appSize12),
          ),
          focusedBorder: focusedBorder ?? UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppSize.appSize12),
          ),
          enabledBorder: enabledBorder ?? UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppSize.appSize12),
          ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
          suffixIconColor: suffixIconColor,
        ),
      ),
    );
  }
}
