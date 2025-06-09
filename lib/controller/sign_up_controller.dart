// // ignore_for_file: unrelated_type_equality_checks

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kongossa/config/app_color.dart';
// import 'package:kongossa/config/app_string.dart';

// class SignUpController extends GetxController {
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController dateOfBirthController = TextEditingController();
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController mobileNumberController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

//   RxBool isPasswordVisible = true.obs;
//   RxBool isConfirmPasswordVisible = true.obs;
//   RxBool isUsernameValid = false.obs;
//   RxBool isShowingUsername = false.obs;
//   RxString isUsername = ''.obs;
//   Rx<DateTime?> selectedDate = DateTime.now().obs;

//    Future<void> registerUser() async {
//     try {
//       // Crée le compte utilisateur avec Firebase Auth
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//         email: usernameController.text.trim() + "@kongossa.com", // Fake email
//         password: passwordController.text.trim(),
//       );

//       String uid = userCredential.user!.uid;

//       // Enregistrement des infos supplémentaires dans Firestore
//       await FirebaseFirestore.instance.collection('users').doc(uid).set({
//         'fullName': fullNameController.text.trim(),
//         'dateOfBirth': dateOfBirthController.text.trim(),
//         'username': usernameController.text.trim(),
//         'mobile': mobileNumberController.text.trim(),
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       Get.snackbar("Succès", "Compte créé avec succès !");
//       // Redirection ou autre action
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         Get.snackbar("Erreur", "Ce nom d'utilisateur est déjà pris.");
//       } else if (e.code == 'weak-password') {
//         Get.snackbar("Erreur", "Le mot de passe est trop faible.");
//       } else {
//         Get.snackbar("Erreur", e.message ?? "Erreur inconnue");
//       }
//     } catch (e) {
//       Get.snackbar("Erreur", "Une erreur est survenue");
//       print("Erreur d'inscription: $e");
//     }
//   }

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   void toggleConfirmPasswordVisibility() {
//     isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
//   }

//   void updateUsernameValidity(String text) {
//     isUsername.value = text;
//     isUsernameValid.value = text.length >= 5;
//     isShowingUsername.value = false;
//   }

//   Future<void> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//       keyboardType: TextInputType.datetime,
//       builder: (BuildContext context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColor.primaryColor,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColor.primaryColor,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != selectedDate.value) {
//       selectedDate.value = picked;
//       String formattedDate =
//           DateFormat(AppString.dateFormatString).format(picked);
//       dateOfBirthController.text = formattedDate;
//     }
//   }

//   @override
//   void dispose() {
//     fullNameController.clear();
//     dateOfBirthController.clear();
//     usernameController.clear();
//     mobileNumberController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
//     isUsernameValid.value = false;
//     super.dispose();
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kongossa/routes/app_routes.dart';

class SignUpController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  RxBool isUsernameValid = false.obs;
  RxBool isShowingUsername = false.obs;
  RxString isUsername = ''.obs;
  Rx<DateTime?> selectedDate = DateTime.now().obs;
  RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void updateUsernameValidity(String text) {
    isUsername.value = text;
    isUsernameValid.value = text.length >= 5;
    isShowingUsername.value = false;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedDate.value = picked;
      dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> registerUser() async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'fullName': fullNameController.text.trim(),
        'dateOfBirth': dateOfBirthController.text.trim(),
        'username': usernameController.text.trim(),
        'mobile': mobileNumberController.text.trim(),
        'email': emailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Succès", "Compte créé avec succès !");
      Get.toNamed(AppRoutes.welcomeView);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Erreur", "Cet email est déjà utilisé.");
      } else if (e.code == 'weak-password') {
        Get.snackbar("Erreur", "Le mot de passe est trop faible.");
      } else {
        Get.snackbar("Erreur", e.message ?? "Erreur inconnue");
      }
    } catch (e) {
      Get.snackbar("Erreur", "Une erreur est survenue");
      debugPrint("Erreur d'inscription: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
