import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kongossa/controller/auth_controller.dart';
import 'package:kongossa/model/comment_model.dart';
import 'dart:async';

import 'package:kongossa/model/post_model.dart';
import 'package:kongossa/model/user_model.dart';
import 'package:kongossa/service/storage_service.dart';

class PostController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final StorageService _storageService = StorageService();

  // Collections
  static const String _postsCollection = 'user_posts';
  static const String _commentsCollection = 'comments';
  static const String _likesCollection = 'likes';
  static const String _savesCollection = 'saves';
  
  // Observable lists
  final RxList<PostModel> allPosts = <PostModel>[].obs;
  final RxList<PostModel> userPosts = <PostModel>[].obs;
  final RxList<PostModel> feedPosts = <PostModel>[].obs;
  final RxList<PostModel> savedPosts = <PostModel>[].obs;
  final RxMap<String, List<Comment>> postComments = <String, List<Comment>>{}.obs;
  
  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isCreating = false.obs;
  final RxBool isUpdating = false.obs;
  final RxBool isDeleting = false.obs;
  final RxBool isLiking = false.obs;
  final RxBool isSaving = false.obs;
  final RxBool isCommenting = false.obs;
  
  // Stream subscriptions
  StreamSubscription<QuerySnapshot>? _feedSubscription;
  StreamSubscription<QuerySnapshot>? _userPostsSubscription;
  StreamSubscription<QuerySnapshot>? _savedPostsSubscription;
  Map<String, StreamSubscription<QuerySnapshot>> _commentSubscriptions = {};
  
  // Current user ID
  String? currentUserId;

  final AuthController _authController = Get.find<AuthController>();
  
  // Pagination
  DocumentSnapshot? _lastFeedDocument;
  DocumentSnapshot? _lastUserPostDocument;
  final int _pageSize = 20;
  final RxBool hasMorePosts = true.obs;
  
  @override
  void onInit() {
    super.onInit();

    currentUserId = _authController.user.value!.uid;

    if (currentUserId != null) {
      startRealtimeListeners();
    }
  }
  
  @override
  void onClose() {
    _feedSubscription?.cancel();
    _userPostsSubscription?.cancel();
    _savedPostsSubscription?.cancel();
    _commentSubscriptions.values.forEach((sub) => sub.cancel());
    super.onClose();
  }
  
  /// Initialise l'utilisateur et démarre les écoutes
  void initializeUser(String userId) {
    currentUserId = userId;
    startRealtimeListeners();
  }
  
  /// Démarre les écoutes en temps réel
  void startRealtimeListeners() {
    if (currentUserId == null) return;
    
    listenToFeed();
    listenToUserPosts(currentUserId!);
    listenToSavedPosts();
  }
  
  /// Écoute du feed principal
  void listenToFeed() {
    _feedSubscription?.cancel();
    
    _feedSubscription = _firestore
        .collection(_postsCollection)
        .where('isActive', isEqualTo: true)
        .where('visibility', whereIn: ['public', 'friends'])
        .orderBy('createdAt', descending: true)
        .limit(_pageSize)
        .snapshots()
        .listen(
      (snapshot) {
        feedPosts.clear();
        for (var doc in snapshot.docs) {
          final post = PostModel.fromMap(doc.data(), doc.id);
          feedPosts.add(post);
        }
        if (snapshot.docs.isNotEmpty) {
          _lastFeedDocument = snapshot.docs.last;
        }
      },
      onError: (error) {
        Get.snackbar('Erreur', 'Erreur lors du chargement du feed: $error');
      },
    );
  }
  
  /// Écoute des posts d'un utilisateur
  void listenToUserPosts(String userId) {
    _userPostsSubscription?.cancel();
    
    _userPostsSubscription = _firestore
        .collection(_postsCollection)
        .where('userId', isEqualTo: userId)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        userPosts.clear();
        for (var doc in snapshot.docs) {
          final post = PostModel.fromMap(doc.data(), doc.id);
          userPosts.add(post);
        }
      },
      onError: (error) {
        Get.snackbar('Erreur', 'Erreur lors du chargement des posts: $error');
      },
    );
  }
  
  /// Écoute des posts sauvegardés
  void listenToSavedPosts() {
    _savedPostsSubscription?.cancel();
    
    _savedPostsSubscription = _firestore
        .collection(_postsCollection)
        .where('savedBy', arrayContains: currentUserId)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        savedPosts.clear();
        for (var doc in snapshot.docs) {
          final post = PostModel.fromMap(doc.data(), doc.id);
          savedPosts.add(post);
        }
      },
      onError: (error) {
        Get.snackbar('Erreur', 'Erreur lors du chargement des posts sauvegardés: $error');
      },
    );
  }
  
  /// Écoute des commentaires d'un post
  void listenToPostComments(String postId) {
    if (_commentSubscriptions.containsKey(postId)) return;
    
    _commentSubscriptions[postId] = _firestore
        .collection(_commentsCollection)
        .where('postId', isEqualTo: postId)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen(
      (snapshot) {
        final comments = <Comment>[];
        for (var doc in snapshot.docs) {
          final comment = Comment.fromMap(doc.data(), doc.id);
          comments.add(comment);
        }
        postComments[postId] = comments;
      },
      onError: (error) {
        Get.snackbar('Erreur', 'Erreur lors du chargement des commentaires: $error');
      },
    );
  }
  
  /// Crée un nouveau post
  Future<bool> createPost({
    required String content,
    List<XFile>? mediaFiles,
    PostType type = PostType.text,
    PostVisibility visibility = PostVisibility.public,
    String? location,
    List<String>? tags,
    List<String>? mentionedUsers,
    Map<String, dynamic>? metadata,
  }) async {
    if (currentUserId == null) {
      Get.snackbar('Erreur', 'Utilisateur non connecté');
      return false;
    }
    
    try {
      isCreating.value = true;
      
      // Upload des médias si présents
      List<String> mediaUrls = [];
      if (mediaFiles != null && mediaFiles.isNotEmpty) {
        mediaUrls = await _storageService.uploadMediaFiles(
          userId: currentUserId!,
          files: mediaFiles,
          folderName: 'posts/$currentUserId',
        );
      }
      
      // Récupération des infos utilisateur
      final userInfo = await _getUserInfo(currentUserId!);
      
      final now = DateTime.now();
      final postRef = _firestore.collection(_postsCollection).doc();
      
      final post = PostModel(
        id: postRef.id,
        userId: currentUserId!,
        username: userInfo?.username ?? '',
        profileImageUrl: userInfo?.profileImageUrl,
        content: content,
        mediaUrls: mediaUrls,
        location: location,
        createdAt: now,
        updatedAt: now,
        type: type,
        visibility: visibility,
        tags: tags ?? [],
        mentionedUsers: mentionedUsers ?? [],
        metadata: metadata,
        hasAudio: type == PostType.audio,
      );
      
      await postRef.set(post.toMap());
      
      // Notification aux utilisateurs mentionnés
      if (mentionedUsers != null && mentionedUsers.isNotEmpty) {
        await _notifyMentionedUsers(post, mentionedUsers);
      }
      
      Get.snackbar('Succès', 'PostModel créé avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la création du post: $e');
      return false;
    } finally {
      isCreating.value = false;
    }
  }
  
  /// Met à jour un post
  Future<bool> updatePost(
    String postId, {
    String? content,
    PostVisibility? visibility,
    String? location,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      isUpdating.value = true;
      
      final updates = <String, dynamic>{
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };
      
      if (content != null) updates['content'] = content;
      if (visibility != null) updates['visibility'] = visibility.toString().split('.').last;
      if (location != null) updates['location'] = location;
      if (tags != null) updates['tags'] = tags;
      if (metadata != null) updates['metadata'] = metadata;
      
      await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .update(updates);
      
      Get.snackbar('Succès', 'PostModel mis à jour avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la mise à jour: $e');
      return false;
    } finally {
      isUpdating.value = false;
    }
  }
  
  /// Supprime un post
  Future<bool> deletePost(String postId) async {
    try {
      isDeleting.value = true;
      
      // Soft delete
      await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .update({
        'isActive': false,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      
      Get.snackbar('Succès', 'PostModel supprimé avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la suppression: $e');
      return false;
    } finally {
      isDeleting.value = false;
    }
  }
  
  /// Like/Unlike un post
  Future<bool> toggleLike(String postId) async {
    if (currentUserId == null) return false;
    
    try {
      isLiking.value = true;
      
      final postRef = _firestore.collection(_postsCollection).doc(postId);
      final postDoc = await postRef.get();
      
      if (!postDoc.exists) return false;
      
      final post = PostModel.fromMap(postDoc.data()!, postDoc.id);
      final isLiked = post.likedBy.contains(currentUserId);
      
      if (isLiked) {
        // Unlike
        await postRef.update({
          'likedBy': FieldValue.arrayRemove([currentUserId]),
        });
      } else {
        // Like
        await postRef.update({
          'likedBy': FieldValue.arrayUnion([currentUserId]),
        });
        
        // Notification au propriétaire du post
        if (post.userId != currentUserId) {
          await _notifyPostOwner(post, 'like');
        }
      }
      
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du like: $e');
      return false;
    } finally {
      isLiking.value = false;
    }
  }
  
  /// Sauvegarder/Désauvegarder un post
  Future<bool> toggleSave(String postId) async {
    if (currentUserId == null) return false;
    
    try {
      isSaving.value = true;
      
      final postRef = _firestore.collection(_postsCollection).doc(postId);
      final postDoc = await postRef.get();
      
      if (!postDoc.exists) return false;
      
      final post = PostModel.fromMap(postDoc.data()!, postDoc.id);
      final isSaved = post.savedBy.contains(currentUserId);
      
      if (isSaved) {
        await postRef.update({
          'savedBy': FieldValue.arrayRemove([currentUserId]),
        });
      } else {
        await postRef.update({
          'savedBy': FieldValue.arrayUnion([currentUserId]),
        });
      }
      
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la sauvegarde: $e');
      return false;
    } finally {
      isSaving.value = false;
    }
  }
  
  /// Partager un post
  Future<bool> sharePost(String postId, {String? message}) async {
    try {
      final postRef = _firestore.collection(_postsCollection).doc(postId);
      
      // Incrémenter le compteur de partages
      await postRef.update({
        'shareCount': FieldValue.increment(1),
      });
      
      // Logique de partage (à implémenter selon vos besoins)
      // Par exemple: partage externe, copie du lien, etc.
      
      Get.snackbar('Succès', 'PostModel partagé avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du partage: $e');
      return false;
    }
  }
  
  /// Reposter un post
  Future<bool> repost(String originalPostId, {String? comment}) async {
    if (currentUserId == null) return false;
    
    try {
      // Récupérer le post original
      final originalPostDoc = await _firestore
          .collection(_postsCollection)
          .doc(originalPostId)
          .get();
      
      if (!originalPostDoc.exists) return false;
      
      final originalPost = PostModel.fromMap(originalPostDoc.data()!, originalPostDoc.id);
      final userInfo = await _getUserInfo(currentUserId!);
      
      final now = DateTime.now();
      final repostRef = _firestore.collection(_postsCollection).doc();
      
      final repost = PostModel(
        id: repostRef.id,
        userId: currentUserId!,
        username: userInfo?.username ?? '',
        profileImageUrl: userInfo?.profileImageUrl,
        content: comment ?? '',
        createdAt: now,
        updatedAt: now,
        type: PostType.text,
        visibility: PostVisibility.public,
        originalPostId: originalPostId,
        originalUserId: originalPost.userId,
        repostComment: comment,
      );
      
      // Batch write pour repost et incrément du compteur
      final batch = _firestore.batch();
      batch.set(repostRef, repost.toMap());
      batch.update(originalPostDoc.reference, {
        'repostCount': FieldValue.increment(1),
      });
      
      await batch.commit();
      
      // Notification au propriétaire du post original
      if (originalPost.userId != currentUserId) {
        await _notifyPostOwner(originalPost, 'repost');
      }
      
      Get.snackbar('Succès', 'PostModel reposté avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du repost: $e');
      return false;
    }
  }
  
  /// Ajouter un commentaire
  Future<bool> addComment(
    String postId, {
    required String content,
    List<XFile>? mediaFiles,
    String? parentCommentId,
    List<String>? mentionedUsers,
  }) async {
    if (currentUserId == null) return false;
    
    try {
      isCommenting.value = true;
      
      // Upload des médias si présents
      List<String> mediaUrls = [];
      if (mediaFiles != null && mediaFiles.isNotEmpty) {
        mediaUrls = await _storageService.uploadMediaFiles(
          userId: currentUserId!,
          files: mediaFiles,
          folderName: 'comments/$currentUserId',
        );
      }
      
      final userInfo = await _getUserInfo(currentUserId!);
      final now = DateTime.now();
      final commentRef = _firestore.collection(_commentsCollection).doc();
      
      final comment = Comment(
        id: commentRef.id,
        postId: postId,
        userId: currentUserId!,
        username: userInfo?.username ?? '',
        profileImageUrl: userInfo?.profileImageUrl,
        content: content,
        mediaUrls: mediaUrls,
        createdAt: now,
        updatedAt: now,
        parentCommentId: parentCommentId,
        mentionedUsers: mentionedUsers ?? [],
      );
      
      // Batch write pour commentaire et incrément du compteur
      final batch = _firestore.batch();
      batch.set(commentRef, comment.toMap());
      batch.update(_firestore.collection(_postsCollection).doc(postId), {
        'commentCount': FieldValue.increment(1),
      });
      
      // Si c'est une réponse à un commentaire
      if (parentCommentId != null) {
        batch.update(_firestore.collection(_commentsCollection).doc(parentCommentId), {
          'replyCount': FieldValue.increment(1),
        });
      }
      
      await batch.commit();
      
      // Démarrer l'écoute des commentaires si pas déjà fait
      if (!_commentSubscriptions.containsKey(postId)) {
        listenToPostComments(postId);
      }
      
      // Notifications
      final post = await getPostById(postId);
      if (post != null && post.userId != currentUserId) {
        await _notifyPostOwner(post, 'comment');
      }
      
      if (mentionedUsers != null && mentionedUsers.isNotEmpty) {
        await _notifyMentionedUsers(post!, mentionedUsers);
      }
      
      Get.snackbar('Succès', 'Commentaire ajouté avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de l\'ajout du commentaire: $e');
      return false;
    } finally {
      isCommenting.value = false;
    }
  }
  
  /// Supprimer un commentaire
  Future<bool> deleteComment(String commentId, String postId) async {
    try {
      // Soft delete du commentaire
      await _firestore
          .collection(_commentsCollection)
          .doc(commentId)
          .update({
        'isActive': false,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      
      // Décrémenter le compteur de commentaires du post
      await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .update({
        'commentCount': FieldValue.increment(-1),
      });
      
      Get.snackbar('Succès', 'Commentaire supprimé avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la suppression: $e');
      return false;
    }
  }
  
  /// Like/Unlike un commentaire
  Future<bool> toggleCommentLike(String commentId) async {
    if (currentUserId == null) return false;
    
    try {
      final commentRef = _firestore.collection(_commentsCollection).doc(commentId);
      final commentDoc = await commentRef.get();
      
      if (!commentDoc.exists) return false;
      
      final comment = Comment.fromMap(commentDoc.data()!, commentDoc.id);
      final isLiked = comment.likedBy.contains(currentUserId);
      
      if (isLiked) {
        await commentRef.update({
          'likedBy': FieldValue.arrayRemove([currentUserId]),
        });
      } else {
        await commentRef.update({
          'likedBy': FieldValue.arrayUnion([currentUserId]),
        });
      }
      
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du like: $e');
      return false;
    }
  }
  
  /// Récupérer un post par ID
  Future<PostModel?> getPostById(String postId) async {
    try {
      final doc = await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .get();
      
      if (doc.exists && doc.data() != null) {
        return PostModel.fromMap(doc.data()!, doc.id);
      }
      return null;
      
    } catch (e) {
      return null;
    }
  }
  
  /// Charger plus de posts dans le feed (pagination)
  Future<void> loadMoreFeedPosts() async {
    if (!hasMorePosts.value || isLoading.value || _lastFeedDocument == null) return;
    
    try {
      isLoading.value = true;
      
      final snapshot = await _firestore
          .collection(_postsCollection)
          .where('isActive', isEqualTo: true)
          .where('visibility', whereIn: ['public', 'friends'])
          .orderBy('createdAt', descending: true)
          .startAfterDocument(_lastFeedDocument!)
          .limit(_pageSize)
          .get();
      
      if (snapshot.docs.isEmpty) {
        hasMorePosts.value = false;
        return;
      }
      
      for (var doc in snapshot.docs) {
        final post = PostModel.fromMap(doc.data(), doc.id);
        feedPosts.add(post);
      }
      
      _lastFeedDocument = snapshot.docs.last;
      
      if (snapshot.docs.length < _pageSize) {
        hasMorePosts.value = false;
      }
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du chargement: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  /// Rechercher des posts
  Future<List<PostModel>> searchPosts(String query) async {
    if (query.trim().isEmpty) return [];
    
    try {
      final snapshot = await _firestore
          .collection(_postsCollection)
          .where('isActive', isEqualTo: true)
          .where('visibility', isEqualTo: 'public')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();
      
      final posts = snapshot.docs
          .map((doc) => PostModel.fromMap(doc.data(), doc.id))
          .where((post) =>
              post.content.toLowerCase().contains(query.toLowerCase()) ||
              post.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())) ||
              post.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
      
      return posts;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la recherche: $e');
      return [];
    }
  }
  
  /// Récupérer les posts par hashtag
  Future<List<PostModel>> getPostsByHashtag(String hashtag) async {
    try {
      final snapshot = await _firestore
          .collection(_postsCollection)
          .where('tags', arrayContains: hashtag)
          .where('isActive', isEqualTo: true)
          .where('visibility', isEqualTo: 'public')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get();
      
      return snapshot.docs
          .map((doc) => PostModel.fromMap(doc.data(), doc.id))
          .toList();
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la récupération: $e');
      return [];
    }
  }
  
  /// Épingler/Désépingler un post
  Future<bool> togglePin(String postId) async {
    try {
      final postDoc = await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .get();
      
      if (!postDoc.exists) return false;
      
      final post = PostModel.fromMap(postDoc.data()!, postDoc.id);
      
      await _firestore
          .collection(_postsCollection)
          .doc(postId)
          .update({
        'isPinned': !post.isPinned,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
      
      Get.snackbar('Succès', post.isPinned ? 'PostModel désépinglé' : 'PostModel épinglé');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de l\'épinglage: $e');
      return false;
    }
  }
  
  /// Récupérer les statistiques d'un post
  Map<String, dynamic> getPostStats(PostModel post) {
    return {
      'likes': post.totalLikes,
      'comments': post.commentCount,
      'shares': post.shareCount,
      'reposts': post.repostCount,
      'saves': post.totalSaves,
      'engagement': post.totalLikes + post.commentCount + post.shareCount + post.repostCount,
    };
  }
  
  /// Vérifier si l'utilisateur actuel a liké un post
  bool isLikedByCurrentUser(PostModel post) {
    return currentUserId != null && post.likedBy.contains(currentUserId);
  }
  
  /// Vérifier si l'utilisateur actuel a sauvegardé un post
  bool isSavedByCurrentUser(PostModel post) {
    return currentUserId != null && post.savedBy.contains(currentUserId);
  }
  
  /// Vérifier si l'utilisateur actuel est le propriétaire du post
  bool isPostOwner(PostModel post) {
    return currentUserId != null && post.userId == currentUserId;
  }
  
  /// Nettoyer les posts inactifs (admin)
  Future<void> cleanupInactivePosts() async {
    try {
      final snapshot = await _firestore
          .collection(_postsCollection)
          .where('isActive', isEqualTo: false)
          .where('updatedAt', isLessThan: Timestamp.fromDate(
              DateTime.now().subtract(const Duration(days: 30))))
          .get();
      
      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      
      await batch.commit();
      
      if (snapshot.docs.isNotEmpty) {
        Get.snackbar('Nettoyage', '${snapshot.docs.length} posts supprimés définitivement');
      }
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du nettoyage: $e');
    }
  }
  
  /// Signaler un post
  Future<bool> reportPost(String postId, String reason) async {
    if (currentUserId == null) return false;
    
    try {
      await _firestore.collection('reports').add({
        'postId': postId,
        'reportedBy': currentUserId,
        'reason': reason,
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'status': 'pending',
        'type': 'post',
      });
      
      Get.snackbar('Succès', 'PostModel signalé avec succès');
      return true;
      
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors du signalement: $e');
      return false;
    }
  }
  
  // Méthodes utilitaires privées
  
  /// Récupérer les informations utilisateur
  Future<UserModel?> _getUserInfo(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  /// Notifier les utilisateurs mentionnés
  Future<void> _notifyMentionedUsers(PostModel post, List<String> mentionedUsers) async {
    final batch = _firestore.batch();
    
    for (String userId in mentionedUsers) {
      if (userId != currentUserId) {
        final notificationRef = _firestore.collection('notifications').doc();
        batch.set(notificationRef, {
          'userId': userId,
          'fromUserId': currentUserId,
          'type': 'mention',
          'postId': post.id,
          'title': 'Nouvelle mention',
          'body': '${post.username} vous a mentionné dans un post',
          'isRead': false,
          'createdAt': Timestamp.fromDate(DateTime.now()),
        });
      }
    }
    
    try {
      await batch.commit();
    } catch (e) {
      print('Erreur notification mentions: $e');
    }
  }
  
  /// Notifier le propriétaire d'un post
  Future<void> _notifyPostOwner(PostModel post, String action) async {
    if (currentUserId == post.userId) return;
    
    final userInfo = await _getUserInfo(currentUserId!);
    String title = '';
    String body = '';
    
    switch (action) {
      case 'like':
        title = 'Nouveau like';
        body = '${userInfo?.username ?? 'Quelqu\'un'} a aimé votre post';
        break;
      case 'comment':
        title = 'Nouveau commentaire';
        body = '${userInfo?.username ?? 'Quelqu\'un'} a commenté votre post';
        break;
      case 'repost':
        title = 'Nouveau repost';
        body = '${userInfo?.username ?? 'Quelqu\'un'} a reposté votre post';
        break;
    }
    
    try {
      await _firestore.collection('notifications').add({
        'userId': post.userId,
        'fromUserId': currentUserId,
        'type': action,
        'postId': post.id,
        'title': title,
        'body': body,
        'isRead': false,
        'createdAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      print('Erreur notification propriétaire: $e');
    }
  }
}