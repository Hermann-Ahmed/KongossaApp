// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   final String uid;
//   final String fullName;
//   final String email;
//   final String mobile;
//   final String username;
//   final String dateOfBirth;
//   final DateTime? createdAt;

//   UserModel({
//     required this.uid,
//     required this.fullName,
//     required this.email,
//     required this.mobile,
//     required this.username,
//     required this.dateOfBirth,
//     this.createdAt,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       uid: map['uid'] ?? '',
//       fullName: map['fullName'] ?? '',
//       email: map['email'] ?? '',
//       mobile: map['mobile'] ?? '',
//       username: map['username'] ?? '',
//       dateOfBirth: map['dateOfBirth'] ?? '',
//       createdAt: map['createdAt'] != null
//           ? (map['createdAt'] as Timestamp).toDate()
//           : null,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String profileImageUrl;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      username: data['username'],
      email: data['email'],
      profileImageUrl: data['profileImageUrl'] ?? 'https://i.pravatar.cc/300',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}