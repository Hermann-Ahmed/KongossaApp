import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String caption;
  final List<String> mediaUrls;
  final List<String> tags;
  final String privacy;
  final int likes;
  final int comments;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.caption,
    required this.mediaUrls,
    required this.tags,
    required this.privacy,
    this.likes = 0,
    this.comments = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      userId: data['userId'],
      caption: data['caption'],
      mediaUrls: List<String>.from(data['mediaUrls']),
      tags: List<String>.from(data['tags']),
      privacy: data['privacy'],
      likes: data['likes'],
      comments: data['comments'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'caption': caption,
      'mediaUrls': mediaUrls,
      'tags': tags,
      'privacy': privacy,
      'likes': likes,
      'comments': comments,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}




// class PostModel {
//   final String id;
//   final String userId;
//   final String imageUrl;
//   final String description;
//   final List<String> likes;
//   final DateTime timestamp;

//   PostModel({
//     required this.id,
//     required this.userId,
//     required this.imageUrl,
//     required this.description,
//     required this.likes,
//     required this.timestamp,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'imageUrl': imageUrl,
//       'description': description,
//       'likes': likes,
//       'timestamp': timestamp,
//     };
//   }
// }





// class Post {
//   final User user;
//   final String caption;
//   final String? imageUrl;
//   final String timeAgo;
//   final int likes;
//   final int comments;
//   final int shares;
//   final String privacyIcon = "🌐";

//   Post({
//     required this.user,
//     required this.caption,
//     this.imageUrl,
//     required this.timeAgo,
//     required this.likes,
//     required this.comments,
//     required this.shares,
//   });
// }

// class User {
//   final String name;
//   final String profileImage;

//   User({required this.name, required this.profileImage});
// }