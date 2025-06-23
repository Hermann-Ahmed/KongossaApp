import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadMediaFiles({
    required String userId,
    required List<XFile> files,
    required String folderName,
  }) async {
    final List<String> urls = [];
    
    for (final file in files) {
      final uniqueName = '${userId}_${DateTime.now().millisecondsSinceEpoch}';
      final ref = _storage.ref('$folderName/$uniqueName');
      await ref.putFile(File(file.path));
      urls.add(await ref.getDownloadURL());
    }

    return urls;
  }
}