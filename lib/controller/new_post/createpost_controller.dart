// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:kongossa/model/posts.dart';

// class CreatePostController extends GetxController {
//   final TextEditingController captionController = TextEditingController();
//   final ImagePicker picker = ImagePicker();
//   Rx<File?> selectedImage = Rx<File?>(null);
//   RxBool isLoading = false.obs;

//   Future<void> pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       selectedImage.value = File(pickedFile.path);
//     }
//   }

//   Future<void> uploadPost() async {
//     if (selectedImage.value == null || captionController.text.trim().isEmpty) return;

//     isLoading.value = true;
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//       String imageName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference ref = FirebaseStorage.instance.ref().child("posts/$imageName.jpg");
//       await ref.putFile(selectedImage.value!);
//       String imageUrl = await ref.getDownloadURL();

//       PostModel post = PostModel(
//         id: '', // Firestore en génère un
//         userId: userId,
//         imageUrl: imageUrl,
//         description: captionController.text.trim(),
//         likes: [],
//         timestamp: DateTime.now(),
//       );

//       await FirebaseFirestore.instance.collection("posts").add(post.toMap());

//       selectedImage.value = null;
//       captionController.clear();
//       Get.back(); // Retour à l'écran précédent
//     } catch (e) {
//       Get.snackbar("Erreur", "Échec de l'envoi du post : $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../service/post_service.dart';
import '../../service/storage_service.dart';

class CreatePostController extends GetxController {
  final PostService _postService = PostService();
  final StorageService _storageService = StorageService();

  var selectedMedia = <XFile>[].obs;
  var selectedTags = <String>[].obs;
  var privacy = 'Public'.obs;
  var isLoading = false.obs;

  final captionController = TextEditingController();
  final tagController = TextEditingController();

  final tagSuggestions = [
    'voyage', 'food', 'art', 'techno', 'mode', 'fitness', 'musique', 'photographie'
  ];

  Future<void> pickMedia() async {
    final picked = await ImagePicker().pickMultiImage();
    if (picked != null) selectedMedia.addAll(picked);
  }

  void addTag() {
    final text = tagController.text.trim().replaceAll(' ', '_').toLowerCase();
    if (text.isNotEmpty && !selectedTags.contains(text)) {
      selectedTags.add(text);
    }
    tagController.clear();
  }

  void removeTag(String tag) => selectedTags.remove(tag);

  Future<void> submitPost(String userId) async {
    if (selectedMedia.isEmpty) return;
    isLoading.value = true;
    try {
      final urls = await _storageService.uploadMediaFiles(
        userId: userId,
        files: selectedMedia,
        folderName: 'posts',
      );
      await _postService.createPost(
        userId: userId,
        caption: captionController.text,
        mediaUrls: urls,
        tags: selectedTags,
        privacy: privacy.value.toLowerCase(),
      );
      Get.back(result: true);
    } catch (e) {
      Get.snackbar('Erreur', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}