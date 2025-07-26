import 'package:cloud_firestore/cloud_firestore.dart';
// Énumérations
enum PostType {
  text,
  image,
  video,
  audio,
  mixed, // Texte + média
  poll,
  event,
  link,
}

enum PostVisibility {
  public,
  friends,
  followers,
  private,
  unlisted, // Visible par lien direct uniquement
}

class PostModel {
  final String id;
  final String userId;
  final String username;
  final String? profileImageUrl;
  final String content;
  final List<String> mediaUrls;
  final String? location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PostType type;
  final PostVisibility visibility;
  
  // Interactions
  final List<String> likedBy;
  final List<String> savedBy;
  final int commentCount;
  final int shareCount;
  final int repostCount;
  
  // Métadonnées
  final List<String> tags;
  final List<String> mentionedUsers;
  final Map<String, dynamic>? metadata;
  
  // Repost info
  final String? originalPostId;
  final String? originalUserId;
  final String? repostComment;
  
  // État du post
  final bool isActive;
  final bool isPinned;
  final bool hasAudio;
  
  PostModel({
    required this.id,
    required this.userId,
    required this.username,
    this.profileImageUrl,
    required this.content,
    this.mediaUrls = const [],
    this.location,
    required this.createdAt,
    required this.updatedAt,
    this.type = PostType.text,
    this.visibility = PostVisibility.public,
    this.likedBy = const [],
    this.savedBy = const [],
    this.commentCount = 0,
    this.shareCount = 0,
    this.repostCount = 0,
    this.tags = const [],
    this.mentionedUsers = const [],
    this.metadata,
    this.originalPostId,
    this.originalUserId,
    this.repostComment,
    this.isActive = true,
    this.isPinned = false,
    this.hasAudio = false,
  });

  factory PostModel.fromMap(Map<String, dynamic> data, String id) {
    return PostModel(
      id: id,
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      content: data['content'] ?? '',
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      location: data['location'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      type: PostType.values.firstWhere(
        (e) => e.toString().split('.').last == data['type'],
        orElse: () => PostType.text,
      ),
      visibility: PostVisibility.values.firstWhere(
        (e) => e.toString().split('.').last == data['visibility'],
        orElse: () => PostVisibility.public,
      ),
      likedBy: List<String>.from(data['likedBy'] ?? []),
      savedBy: List<String>.from(data['savedBy'] ?? []),
      commentCount: data['commentCount'] ?? 0,
      shareCount: data['shareCount'] ?? 0,
      repostCount: data['repostCount'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
      mentionedUsers: List<String>.from(data['mentionedUsers'] ?? []),
      metadata: data['metadata'],
      originalPostId: data['originalPostId'],
      originalUserId: data['originalUserId'],
      repostComment: data['repostComment'],
      isActive: data['isActive'] ?? true,
      isPinned: data['isPinned'] ?? false,
      hasAudio: data['hasAudio'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'content': content,
      'mediaUrls': mediaUrls,
      'location': location,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'type': type.toString().split('.').last,
      'visibility': visibility.toString().split('.').last,
      'likedBy': likedBy,
      'savedBy': savedBy,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'repostCount': repostCount,
      'tags': tags,
      'mentionedUsers': mentionedUsers,
      'metadata': metadata,
      'originalPostId': originalPostId,
      'originalUserId': originalUserId,
      'repostComment': repostComment,
      'isActive': isActive,
      'isPinned': isPinned,
      'hasAudio': hasAudio,
    };
  }

  // Getters utiles
  int get totalLikes => likedBy.length;
  int get totalSaves => savedBy.length;
  bool get isRepost => originalPostId != null;
  bool get hasMedia => mediaUrls.isNotEmpty;
  bool get hasLocation => location != null && location!.isNotEmpty;
  bool get hasTags => tags.isNotEmpty;
  bool get hasMentions => mentionedUsers.isNotEmpty;
  
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}j';
    } else {
      return '${(difference.inDays / 7).floor()}sem';
    }
  }

  // Méthodes de copie pour les mises à jour
  PostModel copyWith({
    String? id,
    String? userId,
    String? username,
    String? profileImageUrl,
    String? content,
    List<String>? mediaUrls,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    PostType? type,
    PostVisibility? visibility,
    List<String>? likedBy,
    List<String>? savedBy,
    int? commentCount,
    int? shareCount,
    int? repostCount,
    List<String>? tags,
    List<String>? mentionedUsers,
    Map<String, dynamic>? metadata,
    String? originalPostId,
    String? originalUserId,
    String? repostComment,
    bool? isActive,
    bool? isPinned,
    bool? hasAudio,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      visibility: visibility ?? this.visibility,
      likedBy: likedBy ?? this.likedBy,
      savedBy: savedBy ?? this.savedBy,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      repostCount: repostCount ?? this.repostCount,
      tags: tags ?? this.tags,
      mentionedUsers: mentionedUsers ?? this.mentionedUsers,
      metadata: metadata ?? this.metadata,
      originalPostId: originalPostId ?? this.originalPostId,
      originalUserId: originalUserId ?? this.originalUserId,
      repostComment: repostComment ?? this.repostComment,
      isActive: isActive ?? this.isActive,
      isPinned: isPinned ?? this.isPinned,
      hasAudio: hasAudio ?? this.hasAudio,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Post{id: $id, userId: $userId, content: $content, type: $type}';
  }
}
