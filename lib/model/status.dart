import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  final String id;
  final String userId;
  final String type;
  final String contentUrl;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String visibility;

  Status({
    required this.id,
    required this.userId,
    required this.type,
    required this.contentUrl,
    required this.createdAt,
    required this.expiresAt,
    required this.visibility,
  });

  factory Status.fromMap(Map<String, dynamic> data) {
    return Status(
      id: data['id'],
      userId: data['userId'] ?? '',
      type: data['type'] ?? 'text',
      contentUrl: data['contentUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      expiresAt: (data['expiresAt'] as Timestamp).toDate(),
      visibility: data['visibility'] ?? 'public',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'contentUrl': contentUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'visibility': visibility,
    };
  }
}
