// import 'dart:async';
// import 'package:get/get.dart';

// import '../routes/app_routes.dart';

// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     Timer(const Duration(seconds: 4), () => Get.offAllNamed(AppRoutes.loginView));
//   }
// }


import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), _navigateUser);
  }

  void _navigateUser() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // L'utilisateur est connecté
      Get.offAllNamed(AppRoutes.bottomBarView); // Remplace par la bonne route d'accueil
    } else {
      // L'utilisateur n'est pas connecté
      Get.offAllNamed(AppRoutes.loginView);
    }
  }
}
