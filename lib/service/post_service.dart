// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PostService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<String> createPost({
//     required String caption,
//     required List<String> mediaUrls,
//     required List<String> tags,
//     required String privacy,
//   }) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) throw Exception('Utilisateur non connecté');

//     final docRef = await _firestore.collection('posts').add({
//       'userId': user.uid,
//       'caption': caption,
//       'mediaUrls': mediaUrls,
//       'tags': tags,
//       'privacy': privacy,
//       'likes': 0,
//       'comments': 0,
//       'createdAt': FieldValue.serverTimestamp(),
//       'updatedAt': FieldValue.serverTimestamp(),
//     });

//     return docRef.id;
//   }

//   Stream<QuerySnapshot> getUserPosts(String userId) {
//     return _firestore
//         .collection('posts')
//         .where('userId', isEqualTo: userId)
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }
// }




import 'package:kongossa/model/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Post> createPost({
    required String userId,
    required String caption,
    required List<String> mediaUrls,
    required List<String> tags,
    required String privacy,
  }) async {
    final docRef = _firestore.collection('posts').doc();
    final post = Post(
      id: docRef.id,
      userId: userId,
      caption: caption,
      mediaUrls: mediaUrls,
      tags: tags,
      privacy: privacy,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await docRef.set(post.toMap());
    return post;
  }

  Stream<List<Post>> getUserPosts(String userId) {
    return _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Post.fromFirestore(doc))
            .toList());
  }
}