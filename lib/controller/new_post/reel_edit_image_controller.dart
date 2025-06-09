// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReelEditImageController extends GetxController {
  Future<void> openGallery() async {
    try {
      final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        print("Image selected from gallery: ${imageFile.path}");
      } else {
        print("No image selected from gallery");
      }
    } catch (e) {
      print("Error opening gallery: $e");
    }
  }
}