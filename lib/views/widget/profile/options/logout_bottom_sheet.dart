// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kongossa/config/app_font.dart';
// import 'package:kongossa/config/app_string.dart';
// import 'package:kongossa/routes/app_routes.dart';
// import '../../../../config/app_color.dart';
// import '../../../../config/app_size.dart';

// logoutBottomSheet(BuildContext context) {
//   return showModalBottomSheet(
//     backgroundColor: AppColor.backgroundColor,
//     shape: const OutlineInputBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(AppSize.appSize12),
//         topRight: Radius.circular(AppSize.appSize12),
//       ),
//       borderSide: BorderSide.none,
//     ),
//     constraints: const BoxConstraints(
//       maxWidth: kIsWeb ? AppSize.appSize800 : double.infinity,
//     ),
//     isScrollControlled: true,
//     useSafeArea: true,
//     context: context,
//     builder: (context) {
//       return Container(
//         height: AppSize.appSize202,
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.only(
//           top: AppSize.appSize12,
//         ),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(AppSize.appSize12),
//             topRight: Radius.circular(AppSize.appSize12),
//           ),
//           color: AppColor.backgroundColor,
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: AppSize.appSize28,
//               height: AppSize.appSize2,
//               margin: const EdgeInsets.only(bottom: AppSize.appSize24),
//               decoration: BoxDecoration(
//                 color: AppColor.lineColor,
//                 borderRadius: BorderRadius.circular(
//                   AppSize.appSize6,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 padding: const EdgeInsets.only(
//                   left: AppSize.appSize20,
//                   right: AppSize.appSize20,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       AppString.logoutT.tr,
//                       style: const TextStyle(
//                         fontSize: AppSize.appSize20,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: AppFont.appFontSemiBold,
//                         color: AppColor.secondaryColor,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: AppSize.appSize18),
//                       child: Text(
//                         AppString.confirmLogoutT.tr,
//                         style: const TextStyle(
//                           fontSize: AppSize.appSize16,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: AppFont.appFontRegular,
//                           color: AppColor.secondaryColor,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: AppSize.appSize32),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 Get.back();
//                               },
//                               child: Container(
//                                 height: AppSize.appSize48,
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.circular(AppSize.appSize66),
//                                   border: Border.all(
//                                     color: AppColor.primaryColor,
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     AppString.cancelT.tr,
//                                     style: const TextStyle(
//                                       fontSize: AppSize.appSize16,
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: AppFont.appFontSemiBold,
//                                       color: AppColor.primaryColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: AppSize.appSize28),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 Get.offAllNamed(AppRoutes.loginView);
//                               },
//                               child: Container(
//                                 height: AppSize.appSize48,
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.circular(AppSize.appSize66),
//                                   color: AppColor.primaryColor,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     AppString.logoutT.tr,
//                                     style: const TextStyle(
//                                       fontSize: AppSize.appSize16,
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: AppFont.appFontSemiBold,
//                                       color: AppColor.secondaryColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/routes/app_routes.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_size.dart';

logoutBottomSheet(BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false; // État pour gérer le loading

  return showModalBottomSheet(
    backgroundColor: AppColor.backgroundColor,
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSize.appSize12),
        topRight: Radius.circular(AppSize.appSize12),
      ),
      borderSide: BorderSide.none,
    ),
    constraints: const BoxConstraints(
      maxWidth: kIsWeb ? AppSize.appSize800 : double.infinity,
    ),
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return StatefulBuilder( // Permet de mettre à jour l'état local
        builder: (context, setState) {
          return Container(
            height: AppSize.appSize202,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: AppSize.appSize12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.appSize12),
                topRight: Radius.circular(AppSize.appSize12),
              ),
              color: AppColor.backgroundColor,
            ),
            child: Column(
              children: [
                Container(
                  width: AppSize.appSize28,
                  height: AppSize.appSize2,
                  margin: const EdgeInsets.only(bottom: AppSize.appSize24),
                  decoration: BoxDecoration(
                    color: AppColor.lineColor,
                    borderRadius: BorderRadius.circular(AppSize.appSize6),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      left: AppSize.appSize20,
                      right: AppSize.appSize20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppString.logoutT.tr,
                          style: const TextStyle(
                            fontSize: AppSize.appSize20,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.appFontSemiBold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppSize.appSize18),
                          child: Text(
                            AppString.confirmLogoutT.tr,
                            style: const TextStyle(
                              fontSize: AppSize.appSize16,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.appFontRegular,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: AppSize.appSize32),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: isLoading
                                      ? null // Désactive le bouton pendant le loading
                                      : () {
                                          Get.back();
                                        },
                                  child: Container(
                                    height: AppSize.appSize48,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.appSize66),
                                      border: Border.all(
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppString.cancelT.tr,
                                        style: const TextStyle(
                                          fontSize: AppSize.appSize16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: AppFont.appFontSemiBold,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSize.appSize28),
                              Expanded(
                                child: GestureDetector(
                                  onTap: isLoading
                                      ? null // Désactive le bouton pendant le loading
                                      : () async {
                                          setState(() {
                                            isLoading = true; // Active le loading
                                          });
                                          try {
                                            await _auth.signOut(); // Déconnexion Firebase
                                            Get.offAllNamed(AppRoutes.loginView); // Redirection
                                          } catch (e) {
                                            setState(() {
                                              isLoading = false; // Désactive le loading en cas d'erreur
                                            });
                                            Get.snackbar(
                                              "Erreur",
                                              "Échec de la déconnexion: ${e.toString()}",
                                            );
                                          }
                                        },
                                  child: Container(
                                    height: AppSize.appSize48,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.appSize66),
                                      color: isLoading
                                          ? AppColor.primaryColor.withOpacity(0.5)
                                          : AppColor.primaryColor,
                                    ),
                                    child: Center(
                                      child: isLoading
                                          ? const CircularProgressIndicator(
                                              color: AppColor.secondaryColor,
                                            )
                                          : Text(
                                              AppString.logoutT.tr,
                                              style: const TextStyle(
                                                fontSize: AppSize.appSize16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.appFontSemiBold,
                                                color: AppColor.secondaryColor,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}