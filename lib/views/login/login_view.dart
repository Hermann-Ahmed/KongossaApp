// // ignore_for_file: must_be_immutable, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kongossa/routes/app_routes.dart';
// import 'package:kongossa/widget/app_button.dart';
// import 'package:kongossa/widget/app_textfield.dart';
// import '../../config/app_color.dart';
// import '../../config/app_font.dart';
// import '../../config/app_icon.dart';
// import '../../config/app_image.dart';
// import '../../config/app_size.dart';
// import '../../config/app_string.dart';
// import '../../controller/login_controller.dart';

// class LoginView extends StatelessWidget {
//   LoginView({Key? key}) : super(key: key);

//   LoginController loginController = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.backgroundColor,
//         body: _body(),
//       ),
//     );
//   }

//   //Login content
//   _body() {
//     return Center(
//       child: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         padding: const EdgeInsets.only(
//           left: AppSize.appSize20,
//           right: AppSize.appSize20,
//           bottom: AppSize.appSize12,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppSize.appSize24),
//               child: Image.asset(
//                 AppImage.appLogo,
//                 width: AppSize.appSize66,
//               ),
//             ),
//             const Text(
//               AppString.primeSocialMedia,
//               style: TextStyle(
//                 fontSize: AppSize.appSize28,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: AppFont.appFontSevillanaRegular,
//                 color: AppColor.secondaryColor,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: AppSize.appSize109),
//               child: AppTextField(
//                 controller: loginController.loginField1Controller,
//                 labelText: AppString.loginField1,
//                 keyboardType: TextInputType.emailAddress,
//                 cursorColor: AppColor.secondaryColor,
//                 fillColor: AppColor.cardBackgroundColor,
//                 textInputAction: TextInputAction.next,
//                 onChanged: (text) {
//                   if (text.isEmpty) {
//                     loginController.isButtonTapped.value = true;
//                   } else {
//                     loginController.isButtonTapped.value = false;
//                   }
//                 },
//                 suffixIcon: Obx(
//                   () => loginController.isButtonTapped.value &&
//                           loginController.loginField1Controller.text.isEmpty
//                       ? Padding(
//                           padding:
//                               const EdgeInsets.only(right: AppSize.appSize16),
//                           child: Image.asset(AppIcon.error),
//                         )
//                       : const SizedBox.shrink(),
//                 ),
//                 suffixIconConstraints: const BoxConstraints(
//                   maxWidth: AppSize.appSize38,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: AppSize.appSize24),
//               child: AppTextField(
//                 controller: loginController.loginField2Controller,
//                 labelText: AppString.loginField2,
//                 keyboardType: TextInputType.text,
//                 cursorColor: AppColor.secondaryColor,
//                 fillColor: AppColor.cardBackgroundColor,
//                 obscureText: true,
//                 textInputAction: TextInputAction.done,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: AppSize.appSize12),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.toNamed(AppRoutes.yourAccountView);
//                   },
//                   child: const Text(
//                     AppString.forgotPassword,
//                     style: TextStyle(
//                       fontSize: AppSize.appSize14,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: AppFont.appFontRegular,
//                       color: AppColor.secondaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             AppButton(
//               onPressed: () {
//                 if (loginController.loginField1Controller.text.isEmpty) {
//                   loginController.isButtonTapped.value = true;
//                 } else {
//                   loginController.isButtonTapped.value = false;
//                   Get.toNamed(AppRoutes.welcomeView);
//                 }
//               },
//               text: AppString.buttonTextLogIn,
//               backgroundColor: AppColor.primaryColor,
//               margin: const EdgeInsets.only(top: AppSize.appSize32),
//             ),
//             AppButton(
//               onPressed: () {
//                 Get.toNamed(AppRoutes.signUpView);
//               },
//               text: AppString.buttonTextSignUp,
//               textColor: AppColor.primaryColor,
//               side: const BorderSide(color: AppColor.primaryColor),
//               margin: const EdgeInsets.only(top: AppSize.appSize12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kongossa/routes/app_routes.dart';
// import '../../config/app_color.dart';
// import '../../config/app_font.dart';
// import '../../config/app_icon.dart';
// import '../../config/app_image.dart';
// import '../../config/app_size.dart';
// import '../../config/app_string.dart';
// import '../../controller/login_controller.dart';

// class LoginView extends StatelessWidget {
//   LoginView({Key? key}) : super(key: key);

//   final LoginController loginController = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.backgroundColor,
//         body: _body(),
//       ),
//     );
//   }

//   Widget _body() {
//     return Center(
//       child: SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         padding: const EdgeInsets.symmetric(
//           horizontal: AppSize.appSize20,
//           vertical: AppSize.appSize12,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppSize.appSize24),
//               child: Image.asset(
//                 AppImage.appLogo,
//                 width: AppSize.appSize66,
//               ),
//             ),
//             const Text(
//               AppString.primeSocialMedia,
//               style: TextStyle(
//                 fontSize: AppSize.appSize28,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: AppFont.appFontSevillanaRegular,
//                 color: AppColor.secondaryColor,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: AppSize.appSize109),
//               child: TextField(
//                 controller: loginController.loginField1Controller,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: AppString.loginField1,
//                   filled: true,
//                   fillColor: AppColor.cardBackgroundColor,
//                   suffixIcon: Obx(() {
//                     return loginController.errorMessage.value.contains("email") &&
//                             loginController.loginField1Controller.text.isNotEmpty
//                         ? Padding(
//                             padding:
//                                 const EdgeInsets.only(right: AppSize.appSize16),
//                             child: Image.asset(AppIcon.error),
//                           )
//                         : const SizedBox.shrink();
//                   }),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: AppSize.appSize24),
//               child: TextField(
//                 controller: loginController.loginField2Controller,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: AppString.loginField2,
//                   filled: true,
//                   fillColor: AppColor.cardBackgroundColor,
//                   suffixIcon: Obx(() {
//                     return loginController.errorMessage.value.contains("mot de passe") &&
//                             loginController.loginField2Controller.text.isNotEmpty
//                         ? Padding(
//                             padding:
//                                 const EdgeInsets.only(right: AppSize.appSize16),
//                             child: Image.asset(AppIcon.error),
//                           )
//                         : const SizedBox.shrink();
//                   }),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: AppSize.appSize12),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.toNamed(AppRoutes.yourAccountView);
//                   },
//                   child: const Text(
//                     AppString.forgotPassword,
//                     style: TextStyle(
//                       fontSize: AppSize.appSize14,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: AppFont.appFontRegular,
//                       color: AppColor.secondaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Obx(() {
//               return loginController.isLoading.value
//                   ? const Padding(
//                       padding: EdgeInsets.only(top: AppSize.appSize32),
//                       child: CircularProgressIndicator(),
//                     )
//                   : Column(
//                       children: [
//                         if (loginController.errorMessage.value.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.only(top: AppSize.appSize12),
//                             child: Text(
//                               loginController.errorMessage.value,
//                               style: TextStyle(
//                                 color: Colors.red.shade700,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: AppSize.appSize32),
//                           child: ElevatedButton(
//                             onPressed: () => loginController.login(),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColor.primaryColor,
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: AppSize.appSize16,
//                                 horizontal: AppSize.appSize32,
//                               ),
//                             ),
//                             child: Text(
//                               AppString.buttonTextLogIn,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: AppSize.appSize16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: AppSize.appSize12),
//                           child: OutlinedButton(
//                             onPressed: () {
//                               Get.toNamed(AppRoutes.signUpView);
//                             },
//                             style: OutlinedButton.styleFrom(
//                               side: BorderSide(color: AppColor.primaryColor),
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: AppSize.appSize16,
//                                 horizontal: AppSize.appSize32,
//                               ),
//                             ),
//                             child: Text(
//                               AppString.buttonTextSignUp,
//                               style: TextStyle(
//                                 color: AppColor.primaryColor,
//                                 fontSize: AppSize.appSize16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }





// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/routes/app_routes.dart';
import 'package:kongossa/widget/app_button.dart';
import 'package:kongossa/widget/app_textfield.dart';
import '../../config/app_color.dart';
import '../../config/app_font.dart';
import '../../config/app_icon.dart';
import '../../config/app_image.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';
import '../../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.appSize20,
          vertical: AppSize.appSize12,
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

            // Champ Email
            Padding(
              padding: const EdgeInsets.only(top: AppSize.appSize109),
              child: AppTextField(
                controller: loginController.loginField1Controller,
                labelText: AppString.loginField1,
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColor.secondaryColor,
                fillColor: AppColor.cardBackgroundColor,
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  loginController.errorMessage.value = '';
                },
                suffixIcon: Obx(() {
                  return loginController.errorMessage.value.contains("email") &&
                          loginController.loginField1Controller.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: AppSize.appSize16),
                          child: Image.asset(AppIcon.error),
                        )
                      : const SizedBox.shrink();
                }),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: AppSize.appSize38,
                ),
              ),
            ),

            // Champ Mot de passe
            Padding(
              padding: const EdgeInsets.only(top: AppSize.appSize24),
              child: AppTextField(
                controller: loginController.loginField2Controller,
                labelText: AppString.loginField2,
                keyboardType: TextInputType.text,
                cursorColor: AppColor.secondaryColor,
                fillColor: AppColor.cardBackgroundColor,
                obscureText: true,
                textInputAction: TextInputAction.done,
                onChanged: (text) {
                  loginController.errorMessage.value = '';
                },
                suffixIcon: Obx(() {
                  return loginController.errorMessage.value.contains("mot de passe") &&
                          loginController.loginField2Controller.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: AppSize.appSize16),
                          child: Image.asset(AppIcon.error),
                        )
                      : const SizedBox.shrink();
                }),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: AppSize.appSize38,
                ),
              ),
            ),

            // Mot de passe oublié
            Padding(
              padding: const EdgeInsets.only(top: AppSize.appSize12),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.yourAccountView);
                  },
                  child: const Text(
                    AppString.forgotPassword,
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

            // Gestion des erreurs ou chargement
            Obx(() {
              return Column(
                children: [
                  if (loginController.errorMessage.value.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSize.appSize12),
                      child: Text(
                        loginController.errorMessage.value,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  loginController.isLoading.value
                      ? const Padding(
                          padding: EdgeInsets.only(top: AppSize.appSize32),
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            AppButton(
                              onPressed: () => loginController.login(),
                              text: AppString.buttonTextLogIn,
                              backgroundColor: AppColor.primaryColor,
                              margin: const EdgeInsets.only(top: AppSize.appSize32),
                            ),
                            AppButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.signUpView);
                              },
                              text: AppString.buttonTextSignUp,
                              textColor: AppColor.primaryColor,
                              side: const BorderSide(color: AppColor.primaryColor),
                              margin: const EdgeInsets.only(top: AppSize.appSize12),
                            ),
                          ],
                        ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
