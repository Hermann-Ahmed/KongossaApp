import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/controller/new_post/post_controller.dart';
import 'package:kongossa/model/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsFeedSection extends StatelessWidget {
  final PostController postController = Get.put<PostController>(PostController());

  PostsFeedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final posts = postController.feedPosts;
      
      if (posts.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Aucun post à afficher',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 32.0,
        ),
        child: Column(
          children: List.generate(posts.length, (index) {
            final socialPost = posts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: socialPost.profileImageUrl != null
                                  ? NetworkImage(socialPost.profileImageUrl!)
                                  : null,
                              backgroundColor: Colors.grey[300],
                              child: socialPost.profileImageUrl == null
                                  ? const Icon(Icons.person, color: Colors.grey)
                                  : null,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                socialPost.username,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              if (socialPost.location != null)
                                Text(
                                  socialPost.location!,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              timeago.format(socialPost.createdAt, locale: 'fr'),
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _showPostOptions(context, socialPost),
                            child: const Icon(
                              Icons.more_horiz,
                              size: 20.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (socialPost.mediaUrls.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              socialPost.mediaUrls.first,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 300,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 300,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 300,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (socialPost.mentionedUsers.isNotEmpty)
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                bottom: 10.0,
                              ),
                              child: Icon(
                                Icons.person_pin,
                                color: Colors.white,
                                size: 24.0,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          if (socialPost.type == PostType.audio || socialPost.type == PostType.video)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10.0,
                                bottom: 10.0,
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  socialPost.type == PostType.audio ? Icons.volume_up : Icons.play_circle,
                                  color: Colors.white,
                                  size: 24.0,
                                  shadows: const [
                                    Shadow(
                                      color: Colors.black54,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _photoOptionWidget(
                          Icons.chat_bubble_outline,
                          22.0,
                          _formatCount(socialPost.commentCount),
                          onTap: () {
                            _commentsBottomSheet(context, socialPost);
                          },
                          onTapText: () {
                            _commentsBottomSheet(context, socialPost);
                          },
                        ),
                        _photoOptionWidget(
                          Icons.repeat,
                          25.0,
                          _formatCount(socialPost.repostCount),
                          onTap: () {
                            _repostBottomSheet(context, socialPost);
                          },
                          onTapText: () {
                            _repostBottomSheet(context, socialPost);
                          },
                        ),
                        _buildLikeWidget(context, socialPost),
                        _photoOptionWidget(
                          Icons.share_outlined,
                          22.0,
                          _formatCount(socialPost.shareCount),
                          onTap: () {
                            postController.sharePost(socialPost.id);
                          },
                        ),
                        _buildSaveWidget(socialPost),
                      ],
                    ),
                  ),
                  _customDivider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: socialPost.username,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: ' ${socialPost.content}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            if (socialPost.tags.isNotEmpty)
                              TextSpan(
                                text: ' ${socialPost.tags.map((tag) => '#$tag').join(' ')}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _buildLikeWidget(BuildContext context, PostModel socialPost) {
    return Obx(() {
      bool isLiked = postController.isLikedByCurrentUser(socialPost);
      return _photoOptionWidget(
        isLiked ? Icons.favorite : Icons.favorite_border,
        26.0,
        _formatCount(socialPost.totalLikes),
        onTap: () {
          postController.toggleLike(socialPost.id);
        },
        onTapText: () {
          _likesBottomSheet(context, socialPost);
        },
        iconColor: isLiked ? Colors.red : Colors.grey,
      );
    });
  }

  Widget _buildSaveWidget(PostModel socialPost) {
    return Obx(() {
      bool isSaved = postController.isSavedByCurrentUser(socialPost);
      return _photoOptionWidget(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        22.0,
        _formatCount(socialPost.totalSaves),
        onTap: () {
          postController.toggleSave(socialPost.id);
        },
        iconColor: isSaved ? Colors.blue : Colors.grey,
      );
    });
  }

  Widget _photoOptionWidget(
    IconData icon,
    double size,
    String count, {
    VoidCallback? onTap,
    VoidCallback? onTapText,
    Color? iconColor,
  }) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Icon(
            icon,
            size: size,
            color: iconColor ?? Colors.grey[600],
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onTapText ?? onTap,
          child: Text(
            count,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _customDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return count.toString();
    }
  }

  void _showPostOptions(BuildContext context, PostModel post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (postController.isPostOwner(post)) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Modifier'),
                onTap: () {
                  Navigator.pop(context);
                  // Logique de modification
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  postController.deletePost(post.id);
                },
              ),
              ListTile(
                leading: Icon(post.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
                title: Text(post.isPinned ? 'Désépingler' : 'Épingler'),
                onTap: () {
                  Navigator.pop(context);
                  postController.togglePin(post.id);
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.flag, color: Colors.red),
                title: const Text('Signaler'),
                onTap: () {
                  Navigator.pop(context);
                  postController.reportPost(post.id, 'Contenu inapproprié');
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Copier le lien'),
              onTap: () {
                Navigator.pop(context);
                // Logique pour copier le lien
              },
            ),
          ],
        ),
      ),
    );
  }

  void _commentsBottomSheet(BuildContext context, PostModel post) {
    // Démarrer l'écoute des commentaires
    postController.listenToPostComments(post.id);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Commentaires (${post.commentCount})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  final comments = postController.postComments[post.id] ?? [];
                  if (comments.isEmpty) {
                    return const Center(
                      child: Text('Aucun commentaire pour le moment'),
                    );
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: comment.profileImageUrl != null
                              ? NetworkImage(comment.profileImageUrl!)
                              : null,
                          child: comment.profileImageUrl == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        title: Text(comment.username),
                        subtitle: Text(comment.content),
                        trailing: Text(timeago.format(comment.createdAt)),
                      );
                    },
                  );
                }),
              ),
              // Zone d'ajout de commentaire
              _buildCommentInput(post),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentInput(PostModel post) {
    final TextEditingController commentController = TextEditingController();
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Ajouter un commentaire...',
                border: InputBorder.none,
              ),
            ),
          ),
          Obx(() => IconButton(
            onPressed: postController.isCommenting.value
                ? null
                : () async {
                    if (commentController.text.trim().isNotEmpty) {
                      await postController.addComment(
                        post.id,
                        content: commentController.text.trim(),
                      );
                      commentController.clear();
                    }
                  },
            icon: postController.isCommenting.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send, color: Colors.blue),
          )),
        ],
      ),
    );
  }

  void _repostBottomSheet(BuildContext context, PostModel post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Reposter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.repeat),
              title: const Text('Reposter'),
              onTap: () {
                Navigator.pop(context);
                postController.repost(post.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Reposter avec commentaire'),
              onTap: () {
                Navigator.pop(context);
                _showRepostWithCommentDialog(context, post);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRepostWithCommentDialog(BuildContext context, PostModel post) {
    final TextEditingController commentController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un commentaire'),
        content: TextField(
          controller: commentController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Ajoutez votre commentaire...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              postController.repost(
                post.id,
                comment: commentController.text.trim(),
              );
            },
            child: const Text('Reposter'),
          ),
        ],
      ),
    );
  }

  void _likesBottomSheet(BuildContext context, PostModel post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'J\'aime (${post.totalLikes})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Liste des utilisateurs qui ont aimé ce post'),
          ],
        ),
      ),
    );
  }
}