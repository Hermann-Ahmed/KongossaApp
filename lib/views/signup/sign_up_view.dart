// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:kongossa/config/app_icon.dart';
// import 'package:kongossa/controller/sign_up_controller.dart';

// import '../../config/app_color.dart';
// import '../../config/app_font.dart';
// import '../../config/app_image.dart';
// import '../../config/app_size.dart';
// import '../../config/app_string.dart';
// import '../../routes/app_routes.dart';
// import '../../widget/app_button.dart';
// import '../../widget/app_textfield.dart';

// class SignUpView extends StatelessWidget {
//   SignUpView({Key? key}) : super(key: key);

//   SignUpController signUpController = Get.put(SignUpController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.backgroundColor,
//         body: _body(context),
//       ),
//     );
//   }

//   //Sign-up content
//   _body(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const ClampingScrollPhysics(),
//       padding: const EdgeInsets.only(
//         top: AppSize.appSize48,
//         left: AppSize.appSize20,
//         right: AppSize.appSize20,
//         bottom: AppSize.appSize12,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: AppSize.appSize24),
//             child: Image.asset(
//               AppImage.appLogo,
//               width: AppSize.appSize66,
//             ),
//           ),
//           const Text(
//             AppString.primeSocialMedia,
//             style: TextStyle(
//               fontSize: AppSize.appSize28,
//               fontWeight: FontWeight.w400,
//               fontFamily: AppFont.appFontSevillanaRegular,
//               color: AppColor.secondaryColor,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: AppSize.appSize52),
//             child: AppTextField(
//               controller: signUpController.fullNameController,
//               labelText: AppString.fullName,
//               keyboardType: TextInputType.text,
//               cursorColor: AppColor.secondaryColor,
//               fillColor: AppColor.cardBackgroundColor,
//               textInputAction: TextInputAction.next,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: AppSize.appSize24),
//             child: AppTextField(
//               controller: signUpController.dateOfBirthController,
//               labelText: AppString.dateOfBirth,
//               keyboardType: TextInputType.text,
//               cursorColor: AppColor.secondaryColor,
//               fillColor: AppColor.cardBackgroundColor,
//               textInputAction: TextInputAction.next,
//               suffixIcon: Padding(
//                 padding: const EdgeInsets.only(right: AppSize.appSize16),
//                 child: GestureDetector(
//                   onTap: () {
//                     signUpController.selectDate(context);
//                   },
//                   child: Image.asset(AppIcon.calendar),
//                 ),
//               ),
//               suffixIconColor: AppColor.text2Color,
//               suffixIconConstraints: const BoxConstraints(
//                 maxWidth: AppSize.appSize35,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: AppSize.appSize24),
//             child: AppTextField(
//               controller: signUpController.usernameController,
//               labelText: AppString.userName,
//               keyboardType: TextInputType.text,
//               cursorColor: AppColor.secondaryColor,
//               fillColor: AppColor.cardBackgroundColor,
//               textInputAction: TextInputAction.next,
//               onChanged: (text) {
//                 signUpController.updateUsernameValidity(text);
//               },
//               suffixIcon: Obx(() {
//                 if (signUpController.isUsername.value.isNotEmpty) {
//                   if (signUpController.isUsernameValid.value) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: AppSize.appSize16),
//                       child: Image.asset(AppIcon.done),
//                     );
//                   } else if (signUpController.isUsername.value.length < 5) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: AppSize.appSize16),
//                       child: Image.asset(AppIcon.error),
//                     );
//                   } else {
//                     return const SizedBox();
//                   }
//                 } else {
//                   if (signUpController.isShowingUsername.value) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: AppSize.appSize16),
//                       child: Image.asset(AppIcon.error),
//                     );
//                   } else {
//                     return const SizedBox();
//                   }
//                 }
//               }),
//               suffixIconColor: AppColor.text2Color,
//               suffixIconConstraints: const BoxConstraints(
//                 maxWidth: AppSize.appSize38,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: AppSize.appSize24),
//             child: AppTextField(
//               controller: signUpController.mobileNumberController,
//               labelText: AppString.mobileNumber,
//               keyboardType: TextInputType.phone,
//               cursorColor: AppColor.secondaryColor,
//               fillColor: AppColor.cardBackgroundColor,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(AppSize.size10),
//               ],
//               textInputAction: TextInputAction.next,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: AppSize.appSize24),
//             child: Obx(() => AppTextField(
//                   controller: signUpController.passwordController,
//                   labelText: AppString.password,
//                   keyboardType: TextInputType.text,
//                   cursorColor: AppColor.secondaryColor,
//                   fillColor: AppColor.cardBackgroundColor,
//                   obscureText: signUpController.isPasswordVisible.value,
//                   textInputAction: TextInputAction.next,
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.only(right: AppSize.appSize16),
//                     child: GestureDetector(
//                       onTap: () {
//                         signUpController.togglePasswordVisibility();
//                       },
//                       child: Image.asset(
//                         signUpController.isPasswordVisible.value
//                             ? AppIcon.eyeClose
//                             : AppIcon.eyeOpen,
//                       ),
//                     ),
//                   ),
//                   suffixIconColor: AppColor.text2Color,
//                   suffixIconConstraints: const BoxConstraints(
//                     maxWidth: AppSize.appSize38,
//                   ),
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: AppSize.appSize24),
//             child: Obx(() => AppTextField(
//                   controller: signUpController.confirmPasswordController,
//                   labelText: AppString.confirmPassword,
//                   keyboardType: TextInputType.text,
//                   cursorColor: AppColor.secondaryColor,
//                   fillColor: AppColor.cardBackgroundColor,
//                   obscureText: signUpController.isConfirmPasswordVisible.value,
//                   textInputAction: TextInputAction.done,
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.only(right: AppSize.appSize16),
//                     child: GestureDetector(
//                       onTap: () {
//                         signUpController.toggleConfirmPasswordVisibility();
//                       },
//                       child: Image.asset(
//                         signUpController.isConfirmPasswordVisible.value
//                             ? AppIcon.eyeClose
//                             : AppIcon.eyeOpen,
//                       ),
//                     ),
//                   ),
//                   suffixIconColor: AppColor.text2Color,
//                   suffixIconConstraints: const BoxConstraints(
//                     maxWidth: AppSize.appSize38,
//                   ),
//                 )),
//           ),
//           AppButton(
//             onPressed: () {
//               if (signUpController.usernameController.text.isEmpty) {
//                 signUpController.isShowingUsername.value = true;
//               } else {
//                 Get.toNamed(AppRoutes.welcomeView);
//               }
//             },
//             text: AppString.buttonTextSignUp,
//             backgroundColor: AppColor.primaryColor,
//             margin: const EdgeInsets.only(top: AppSize.appSize32),
//           ),
//           AppButton(
//             onPressed: () {
//               Get.toNamed(AppRoutes.loginView);
//             },
//             text: AppString.buttonTextLogIn,
//             textColor: AppColor.primaryColor,
//             side: const BorderSide(color: AppColor.primaryColor),
//             margin: const EdgeInsets.only(top: AppSize.appSize12),
//           ),
//         ],
//       ),
//     );
//   }
// }




// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/controller/sign_up_controller.dart';

import '../../config/app_color.dart';
import '../../config/app_font.dart';
import '../../config/app_image.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';
import '../../routes/app_routes.dart';
import '../../widget/app_button.dart';
import '../../widget/app_textfield.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Obx(() => signUpController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _body(context)),
      ),
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: AppSize.appSize48,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
        bottom: AppSize.appSize12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.appSize24),
            child: Image.asset(
              AppImage.appLogo,
              width: AppSize.appSize66,
            ),
          ),
          const Text(
            AppString.primeSocialMedia,
            style: TextStyle(
              fontSize: AppSize.appSize28,
              fontWeight: FontWeight.w400,
              fontFamily: AppFont.appFontSevillanaRegular,
              color: AppColor.secondaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize52),
            child: AppTextField(
              controller: signUpController.fullNameController,
              labelText: AppString.fullName,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.secondaryColor,
              fillColor: AppColor.cardBackgroundColor,
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: signUpController.dateOfBirthController,
              labelText: AppString.dateOfBirth,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.secondaryColor,
              fillColor: AppColor.cardBackgroundColor,
              textInputAction: TextInputAction.next,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: AppSize.appSize16),
                child: GestureDetector(
                  onTap: () {
                    signUpController.selectDate(context);
                  },
                  child: Image.asset(AppIcon.calendar),
                ),
              ),
              suffixIconColor: AppColor.text2Color,
              suffixIconConstraints:
                  const BoxConstraints(maxWidth: AppSize.appSize35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: signUpController.usernameController,
              labelText: AppString.userName,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.secondaryColor,
              fillColor: AppColor.cardBackgroundColor,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                signUpController.updateUsernameValidity(text);
              },
              suffixIcon: Obx(() {
                if (signUpController.isUsername.value.isNotEmpty) {
                  if (signUpController.isUsernameValid.value) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSize.appSize16),
                      child: Image.asset(AppIcon.done),
                    );
                  } else if (signUpController.isUsername.value.length < 5) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSize.appSize16),
                      child: Image.asset(AppIcon.error),
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  if (signUpController.isShowingUsername.value) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSize.appSize16),
                      child: Image.asset(AppIcon.error),
                    );
                  } else {
                    return const SizedBox();
                  }
                }
              }),
              suffixIconColor: AppColor.text2Color,
              suffixIconConstraints:
                  const BoxConstraints(maxWidth: AppSize.appSize38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: signUpController.emailController,
              labelText: "Email",
              keyboardType: TextInputType.emailAddress,
              cursorColor: AppColor.secondaryColor,
              fillColor: AppColor.cardBackgroundColor,
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: AppTextField(
              controller: signUpController.mobileNumberController,
              labelText: AppString.mobileNumber,
              keyboardType: TextInputType.phone,
              cursorColor: AppColor.secondaryColor,
              fillColor: AppColor.cardBackgroundColor,
              inputFormatters: [
                LengthLimitingTextInputFormatter(AppSize.size10),
              ],
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: Obx(() => AppTextField(
                  controller: signUpController.passwordController,
                  labelText: AppString.password,
                  keyboardType: TextInputType.text,
                  cursorColor: AppColor.secondaryColor,
                  fillColor: AppColor.cardBackgroundColor,
                  obscureText: signUpController.isPasswordVisible.value,
                  textInputAction: TextInputAction.next,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: AppSize.appSize16),
                    child: GestureDetector(
                      onTap: () {
                        signUpController.togglePasswordVisibility();
                      },
                      child: Image.asset(
                        signUpController.isPasswordVisible.value
                            ? AppIcon.eyeClose
                            : AppIcon.eyeOpen,
                      ),
                    ),
                  ),
                  suffixIconColor: AppColor.text2Color,
                  suffixIconConstraints:
                      const BoxConstraints(maxWidth: AppSize.appSize38),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSize.appSize24),
            child: Obx(() => AppTextField(
                  controller: signUpController.confirmPasswordController,
                  labelText: AppString.confirmPassword,
                  keyboardType: TextInputType.text,
                  cursorColor: AppColor.secondaryColor,
                  fillColor: AppColor.cardBackgroundColor,
                  obscureText: signUpController.isConfirmPasswordVisible.value,
                  textInputAction: TextInputAction.done,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: AppSize.appSize16),
                    child: GestureDetector(
                      onTap: () {
                        signUpController.toggleConfirmPasswordVisibility();
                      },
                      child: Image.asset(
                        signUpController.isConfirmPasswordVisible.value
                            ? AppIcon.eyeClose
                            : AppIcon.eyeOpen,
                      ),
                    ),
                  ),
                  suffixIconColor: AppColor.text2Color,
                  suffixIconConstraints:
                      const BoxConstraints(maxWidth: AppSize.appSize38),
                )),
          ),
          AppButton(
            onPressed: () {
              if (signUpController.usernameController.text.isEmpty) {
                signUpController.isShowingUsername.value = true;
              } else {
                signUpController.registerUser();
              }
            },
            text: AppString.buttonTextSignUp,
            backgroundColor: AppColor.primaryColor,
            margin: const EdgeInsets.only(top: AppSize.appSize32),
          ),
          AppButton(
            onPressed: () {
              Get.toNamed(AppRoutes.loginView);
            },
            text: AppString.buttonTextLogIn,
            textColor: AppColor.primaryColor,
            side: const BorderSide(color: AppColor.primaryColor),
            margin: const EdgeInsets.only(top: AppSize.appSize12),
          ),
        ],
      ),
    );
  }
}

