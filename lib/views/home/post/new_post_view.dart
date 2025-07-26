import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kongossa/controller/new_post/post_controller.dart';
import 'package:kongossa/model/post_model.dart';
import 'dart:io';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  PostType _selectedType = PostType.text;
  PostVisibility _selectedVisibility = PostVisibility.public;
  
  List<String> _tags = [];
  List<String> _mentionedUsers = [];
  
  bool _isLocationEnabled = false;
  bool _isAudioPost = false;

  @override
  void dispose() {
    _contentController.dispose();
    _locationController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Créer un post',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: _postController.isCreating.value ? null : _createPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: _postController.isCreating.value
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Publier',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Zone de texte principale
            _buildContentSection(),
            
            const SizedBox(height: 20),
            
            // Médias sélectionnés
            if (_selectedFiles.isNotEmpty) _buildSelectedMedia(),
            
            const SizedBox(height: 20),
            
            // Options du post
            _buildPostOptions(),
            
            const SizedBox(height: 20),
            
            // Tags
            _buildTagsSection(),
            
            const SizedBox(height: 20),
            
            // Actions rapides
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar et info utilisateur
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.person, color: Colors.blue),
                ),
                const SizedBox(width: 12),
               const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Votre nom',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    // _buildVisibilityChip(),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Zone de texte
            TextField(
              controller: _contentController,
              maxLines: null,
              minLines: 4,
              decoration: const InputDecoration(
                hintText: 'Que voulez-vous partager ?',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
              onChanged: _detectMentions,
            ),
            
            // Location si activée
            if (_isLocationEnabled) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                  hintText: 'Ajouter un lieu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilityChip() {
    return GestureDetector(
      onTap: _showVisibilityOptions,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getVisibilityIcon(),
              size: 14,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              _getVisibilityText(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedMedia() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Médias sélectionnés',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _selectedFiles.clear()),
                  child: const Text('Tout supprimer'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedFiles.length,
                itemBuilder: (context, index) {
                  final file = _selectedFiles[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(file.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeMedia(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostOptions() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Options du post',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            
            // Type de post
            Row(
              children: [
                const Icon(Icons.text_fields, color: Colors.blue),
                const SizedBox(width: 12),
                const Text('Type de post'),
                const Spacer(),
                DropdownButton<PostType>(
                  value: _selectedType,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: PostType.text,
                      child: Text('Texte'),
                    ),
                    DropdownMenuItem(
                      value: PostType.image,
                      child: Text('Image'),
                    ),
                    DropdownMenuItem(
                      value: PostType.video,
                      child: Text('Vidéo'),
                    ),
                    DropdownMenuItem(
                      value: PostType.audio,
                      child: Text('Audio'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedType = value;
                        _isAudioPost = value == PostType.audio;
                      });
                    }
                  },
                ),
              ],
            ),
            
            const Divider(),
            
            // Localisation
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Ajouter un lieu'),
                ],
              ),
              value: _isLocationEnabled,
              onChanged: (value) {
                setState(() {
                  _isLocationEnabled = value;
                  if (!value) {
                    _locationController.clear();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tags',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            
            // Champ d'ajout de tag
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: InputDecoration(
                      hintText: 'Ajouter un tag (sans #)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: _addTag,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTag(_tagController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Ajouter'),
                ),
              ],
            ),
            
            // Tags ajoutés
            if (_tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _tags.map((tag) => Chip(
                  label: Text('#$tag'),
                  backgroundColor: Colors.blue[50],
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () => _removeTag(tag),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajouter à votre post',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.photo,
                  label: 'Photo',
                  color: Colors.green,
                  onTap: () => _pickMedia(ImageSource.gallery),
                ),
                _buildActionButton(
                  icon: Icons.camera_alt,
                  label: 'Caméra',
                  color: Colors.blue,
                  onTap: () => _pickMedia(ImageSource.camera),
                ),
                _buildActionButton(
                  icon: Icons.videocam,
                  label: 'Vidéo',
                  color: Colors.red,
                  onTap: _pickVideo,
                ),
                _buildActionButton(
                  icon: Icons.mic,
                  label: 'Audio',
                  color: Colors.orange,
                  onTap: _toggleAudioPost,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // Méthodes utilitaires

  IconData _getVisibilityIcon() {
    switch (_selectedVisibility) {
      case PostVisibility.public:
        return Icons.public;
      case PostVisibility.friends:
        return Icons.group;
      case PostVisibility.private:
        return Icons.lock;
      case PostVisibility.followers:
        // TODO: Handle this case.
        throw UnimplementedError();
      case PostVisibility.unlisted:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  String _getVisibilityText() {
    switch (_selectedVisibility) {
      case PostVisibility.public:
        return 'Public';
      case PostVisibility.friends:
        return 'Amis';
      case PostVisibility.private:
        return 'Privé';
      case PostVisibility.followers:
        // TODO: Handle this case.
        throw UnimplementedError();
      case PostVisibility.unlisted:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void _showVisibilityOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Qui peut voir ce post ?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            
            ...PostVisibility.values.map((visibility) => ListTile(
              leading: Icon(_getVisibilityIconForValue(visibility)),
              title: Text(_getVisibilityTextForValue(visibility)),
              trailing: _selectedVisibility == visibility
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  _selectedVisibility = visibility;
                });
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  IconData _getVisibilityIconForValue(PostVisibility visibility) {
    switch (visibility) {
      case PostVisibility.public:
        return Icons.public;
      case PostVisibility.friends:
        return Icons.group;
      case PostVisibility.private:
        return Icons.lock;
      case PostVisibility.followers:
        // TODO: Handle this case.
        throw UnimplementedError();
      case PostVisibility.unlisted:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  String _getVisibilityTextForValue(PostVisibility visibility) {
    switch (visibility) {
      case PostVisibility.public:
        return 'Public';
      case PostVisibility.friends:
        return 'Amis seulement';
      case PostVisibility.private:
        return 'Seulement moi';
      case PostVisibility.followers:
        // TODO: Handle this case.
        throw UnimplementedError();
      case PostVisibility.unlisted:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void _detectMentions(String text) {
    final mentionRegex = RegExp(r'@(\w+)');
    final matches = mentionRegex.allMatches(text);
    
    setState(() {
      _mentionedUsers.clear();
      for (final match in matches) {
        final username = match.group(1);
        if (username != null && !_mentionedUsers.contains(username)) {
          _mentionedUsers.add(username);
        }
      }
    });
  }

  void _addTag(String tag) {
    if (tag.trim().isNotEmpty && !_tags.contains(tag.trim())) {
      setState(() {
        _tags.add(tag.trim());
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  Future<void> _pickMedia(ImageSource source) async {
    try {
      final XFile? file = await _picker.pickImage(source: source);
      if (file != null) {
        setState(() {
          _selectedFiles.add(file);
          _selectedType = PostType.image;
        });
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la sélection de l\'image');
    }
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          _selectedFiles.add(file);
          _selectedType = PostType.video;
        });
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur lors de la sélection de la vidéo');
    }
  }

  void _toggleAudioPost() {
    setState(() {
      _isAudioPost = !_isAudioPost;
      if (_isAudioPost) {
        _selectedType = PostType.audio;
      } else {
        _selectedType = PostType.text;
      }
    });
  }

  void _removeMedia(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
      if (_selectedFiles.isEmpty) {
        _selectedType = PostType.text;
      }
    });
  }

  Future<void> _createPost() async {
    if (_contentController.text.trim().isEmpty && _selectedFiles.isEmpty) {
      Get.snackbar('Erreur', 'Veuillez ajouter du contenu à votre post');
      return;
    }

    final success = await _postController.createPost(
      content: _contentController.text.trim(),
      mediaFiles: _selectedFiles.isEmpty ? null : _selectedFiles,
      type: _selectedType,
      visibility: _selectedVisibility,
      location: _isLocationEnabled ? _locationController.text.trim() : null,
      tags: _tags,
      mentionedUsers: _mentionedUsers,
      metadata: _isAudioPost ? {'isAudio': true} : null,
    );

    if (success) {
      Get.back();
    }
  }
}