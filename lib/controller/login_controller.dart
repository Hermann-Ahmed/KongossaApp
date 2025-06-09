// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// class LoginController extends GetxController {
//   TextEditingController loginField1Controller = TextEditingController();
//   TextEditingController loginField2Controller = TextEditingController();

//   RxBool isButtonTapped = false.obs;

//   @override
//   void dispose() {
//     loginField1Controller.clear();
//     loginField2Controller.clear();
//     isButtonTapped.value = false;
//     super.dispose();
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  final loginField1Controller = TextEditingController(); // email
  final loginField2Controller = TextEditingController(); // password

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> login() async {
    final email = loginField1Controller.text.trim();
    final password = loginField2Controller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = "Veuillez remplir tous les champs";
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Connexion réussie, redirection
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.welcomeView);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      if (e.code == 'user-not-found') {
        errorMessage.value = 'Utilisateur non trouvé pour cet email.';
      } else if (e.code == 'wrong-password') {
        errorMessage.value = 'Mot de passe incorrect.';
      } else if (e.code == 'invalid-email') {
        errorMessage.value = 'Email invalide.';
      } else {
        errorMessage.value = 'Erreur: ${e.message}';
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Erreur inattendue. Veuillez réessayer.';
    }
  }

  @override
  void dispose() {
    loginField1Controller.dispose();
    loginField2Controller.dispose();
    super.dispose();
  }
}
