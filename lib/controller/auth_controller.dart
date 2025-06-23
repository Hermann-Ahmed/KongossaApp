import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../service/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var user = Rxn<UserModel>();
  StreamSubscription<User?>? _authSub;

  @override
  void onInit() {
    super.onInit();
    // Listen to Firebase auth changes
    _authSub = _authService.user.listen((firebaseUser) async {
      if (firebaseUser == null) {
        user.value = null;
      } else {
        user.value = await _authService.getCurrentUser();
      }
    });
  }

  @override
  void onClose() {
    _authSub?.cancel();
    super.onClose();
  }

  Future<void> signOut() => _authService.signOut();
}
