import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


/*
Gère un champ texte via TextEditingController

Nettoie le champ texte à la destruction du contrôleur (dispose())
 */

class CommentsController extends GetxController {
  TextEditingController commentsFieldController = TextEditingController();

  @override
  void dispose() {
    commentsFieldController.clear();
    super.dispose();
  }
}