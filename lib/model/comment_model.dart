import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String postId;
  final String userId;
  final String username;
  final String? profileImageUrl;
  final String content;
  final List<String> mediaUrls;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> likedBy;
  final List<String> mentionedUsers;
  final String? parentCommentId; // Pour les réponses
  final int replyCount;
  final bool isActive;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    this.profileImageUrl,
    required this.content,
    this.mediaUrls = const [],
    required this.createdAt,
    required this.updatedAt,
    this.likedBy = const [],
    this.mentionedUsers = const [],
    this.parentCommentId,
    this.replyCount = 0,
    this.isActive = true,
  });

  factory Comment.fromMap(Map<String, dynamic> data, String id) {
    return Comment(
      id: id,
      postId: data['postId'] ?? '',
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      content: data['content'] ?? '',
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      likedBy: List<String>.from(data['likedBy'] ?? []),
      mentionedUsers: List<String>.from(data['mentionedUsers'] ?? []),
      parentCommentId: data['parentCommentId'],
      replyCount: data['replyCount'] ?? 0,
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'content': content,
      'mediaUrls': mediaUrls,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'likedBy': likedBy,
      'mentionedUsers': mentionedUsers,
      'parentCommentId': parentCommentId,
      'replyCount': replyCount,
      'isActive': isActive,
    };
  }

  int get totalLikes => likedBy.length;
  bool get isReply => parentCommentId != null;
  bool get hasReplies => replyCount > 0;
  bool get hasMedia => mediaUrls.isNotEmpty;

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}j';
    }
  }
}