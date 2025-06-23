// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';

// class AwesomeAddPostScreen extends StatefulWidget {
//   @override
//   _AwesomeAddPostScreenState createState() => _AwesomeAddPostScreenState();
// }

// class _AwesomeAddPostScreenState extends State<AwesomeAddPostScreen> {
//   final TextEditingController _captionController = TextEditingController();
//   XFile? _selectedImage;
//   List<String> _selectedTags = [];
//   bool _isLoading = false;
//   String _privacy = 'Public';

//   final List<String> _tagSuggestions = [
//     'voyage', 'food', 'art', 'techno', 'mode',
//     'fitness', 'musique', 'photographie'
//   ];

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() => _selectedImage = image);
//     }
//   }

//   void _toggleTag(String tag) {
//     setState(() {
//       if (_selectedTags.contains(tag)) {
//         _selectedTags.remove(tag);
//       } else {
//         _selectedTags.add(tag);
//       }
//     });
//   }

//   void _submitPost() async {
//     if (_selectedImage == null) return;

//     setState(() => _isLoading = true);

//     // Simulate API call
//     await Future.delayed(Duration(seconds: 2));

//     setState(() => _isLoading = false);
//     Navigator.pop(context, true); // Return success
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       title: Text(
//         'Nouveau Post',
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//       centerTitle: true,
//       elevation: 0.5,
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.close, color: Colors.black),
//         onPressed: () => Navigator.pop(context),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _selectedImage != null ? _submitPost : null,
//           child: Text(
//             'Partager',
//             style: TextStyle(
//               color: _selectedImage != null ? Colors.blue : Colors.grey,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBody() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildAuthorSection(),
//           SizedBox(height: 20),
//           _buildCaptionInput(),
//           SizedBox(height: 20),
//           _buildImagePreview(),
//           SizedBox(height: 20),
//           _buildTagSection(),
//           SizedBox(height: 20),
//           _buildPrivacySelector(),
//         ],
//       ),
//     );
//   }

//   Widget _buildAuthorSection() {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
//         ),
//         SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Jean Dupont',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             DropdownButton<String>(
//               value: _privacy,
//               underline: Container(),
//               iconSize: 16,
//               items: [
//                 DropdownMenuItem(
//                   value: 'Public',
//                   child: Row(
//                     children: [
//                       Icon(Icons.public, size: 16),
//                       SizedBox(width: 5),
//                       Text('Public'),
//                     ],
//                   ),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Amis',
//                   child: Row(
//                     children: [
//                       Icon(Icons.people, size: 16),
//                       SizedBox(width: 5),
//                       Text('Amis seulement'),
//                     ],
//                   ),
//                 ),
//               ],
//               onChanged: (value) {
//                 setState(() => _privacy = value!);
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildCaptionInput() {
//     return TextField(
//       controller: _captionController,
//       maxLines: 5,
//       minLines: 1,
//       decoration: InputDecoration(
//         hintText: 'Quoi de neuf ?',
//         border: InputBorder.none,
//       ),
//       style: TextStyle(fontSize: 16),
//     );
//   }

//   Widget _buildImagePreview() {
//     return GestureDetector(
//       onTap: _pickImage,
//       child: Container(
//         height: 300,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: Colors.grey[300]!,
//             width: 1,
//           ),
//         ),
//         child: _selectedImage != null
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.file(
//                   File(_selectedImage!.path),
//                   fit: BoxFit.cover,
//                 ),
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
//                   SizedBox(height: 10),
//                   Text(
//                     'Ajouter une photo/vidéo',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   Widget _buildTagSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Ajouter des tags',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         SizedBox(height: 10),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: _tagSuggestions.map((tag) {
//             final isSelected = _selectedTags.contains(tag);
//             return FilterChip(
//               label: Text('#$tag'),
//               selected: isSelected,
//               onSelected: (_) => _toggleTag(tag),
//               selectedColor: Colors.blue[50],
//               checkmarkColor: Colors.blue,
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.blue : Colors.black,
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildPrivacySelector() {
//     return ListTile(
//       leading: Icon(Icons.privacy_tip, color: Colors.blue),
//       title: Text('Qui peut voir ce post ?'),
//       subtitle: Text(_privacy),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   title: Text('Public'),
//                   leading: Icon(Icons.public),
//                   onTap: () {
//                     setState(() => _privacy = 'Public');
//                     Navigator.pop(context);
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Amis seulement'),
//                   leading: Icon(Icons.people),
//                   onTap: () {
//                     setState(() => _privacy = 'Amis');
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildBottomBar() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: Colors.grey[200]!))),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             icon: SvgPicture.asset('assets/icons/gallery.svg', width: 24),
//             onPressed: _pickImage,
//           ),
//           IconButton(
//             icon: Icon(Icons.tag, size: 24),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.location_on, size: 24),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.more_horiz, size: 24),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kongossa/model/user_model.dart';
// import 'package:kongossa/service/post_service.dart';
// import 'package:provider/provider.dart';

// class AdvancedAddPostScreen extends StatefulWidget {
//   @override
//   _AdvancedAddPostScreenState createState() => _AdvancedAddPostScreenState();
// }

// class _AdvancedAddPostScreenState extends State<AdvancedAddPostScreen> {
//   final TextEditingController _captionController = TextEditingController();
//   final TextEditingController _tagController = TextEditingController();
//   List<XFile> _selectedMedia = [];
//   List<String> _selectedTags = [];
//   String _privacy = 'Public';
//   bool _isLoading = false;

//   final List<String> _tagSuggestions = [
//     'voyage', 'food', 'art', 'techno', 'mode',
//     'fitness', 'musique', 'photographie'
//   ];

// Future<void> _pickMedia() async {
//   final pickedFiles = await ImagePicker().pickMultiImage();
//   if (pickedFiles != null) {
//     setState(() => _selectedMedia.addAll(pickedFiles));
//   }
// }

//   void _addTag() {
//     if (_tagController.text.trim().isNotEmpty) {
//       final newTag = _tagController.text.trim().replaceAll(' ', '_').toLowerCase();
//       if (!_selectedTags.contains(newTag)) {
//         setState(() => _selectedTags.add(newTag));
//       }
//       _tagController.clear();
//     }
//   }

//   void _removeTag(String tag) {
//     setState(() => _selectedTags.remove(tag));
//   }

//   Future<void> _submitPost() async {
//     if (_selectedMedia.isEmpty) return;

//     setState(() => _isLoading = true);

//     try {
//       final user = Provider.of<UserModel>(context, listen: false);
//       final mediaUrls = await StorageService.uploadMultipleMedia(_selectedMedia);

//       await PostService.createPost(
//         userId: user.id,
//         caption: _captionController.text,
//         mediaUrls: mediaUrls,
//         tags: _selectedTags,
//         privacy: _privacy,
//       );

//       Navigator.pop(context, true); // Retour avec succès
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erreur: ${e.toString()}')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserModel>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: _buildBody(user),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       title: Text('Nouveau Post', style: TextStyle(color: Colors.black)),
//       centerTitle: true,
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.close, color: Colors.black),
//         onPressed: () => Navigator.pop(context),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _selectedMedia.isNotEmpty ? _submitPost : null,
//           child: _isLoading
//               ? CircularProgressIndicator(color: Colors.blue)
//               : Text('Partager', style: TextStyle(color: Colors.blue)),
//         ),
//       ],
//     );
//   }

//   Widget _buildBody(UserModel user) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildAuthorSection(user),
//           SizedBox(height: 20),
//           _buildCaptionInput(),
//           SizedBox(height: 20),
//           _buildMediaGrid(),
//           SizedBox(height: 20),
//           _buildTagInput(),
//           _buildTagChips(),
//           SizedBox(height: 10),
//           _buildSuggestedTags(),
//           SizedBox(height: 20),
//           _buildPrivacySelector(),
//         ],
//       ),
//     );
//   }

//   Widget _buildAuthorSection(UserModel user) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundImage: NetworkImage(user.profileImageUrl),
//         ),
//         SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(user.username, style: TextStyle(fontWeight: FontWeight.bold)),
//             DropdownButton<String>(
//               value: _privacy,
//               items: [
//                 DropdownMenuItem(
//                   value: 'Public',
//                   child: Row(
//                     children: [
//                       Icon(Icons.public, size: 16),
//                       SizedBox(width: 5),
//                       Text('Public'),
//                     ],
//                   ),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Amis',
//                   child: Row(
//                     children: [
//                       Icon(Icons.people, size: 16),
//                       SizedBox(width: 5),
//                       Text('Amis seulement'),
//                     ],
//                   ),
//                 ),
//               ],
//               onChanged: (value) => setState(() => _privacy = value!),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildCaptionInput() {
//     return TextField(
//       controller: _captionController,
//       maxLines: 5,
//       minLines: 1,
//       decoration: InputDecoration(
//         hintText: 'Quoi de neuf ?',
//         border: InputBorder.none,
//       ),
//     );
//   }

//   Widget _buildMediaGrid() {
//     return GestureDetector(
//       onTap: _pickMedia,
//       child: Container(
//         height: 200,
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey[300]!),
//         ),
//         child: _selectedMedia.isEmpty
//             ? Center(child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
//                   Text('Ajouter des médias', style: TextStyle(color: Colors.grey)),
//                 ],
//               ))
//             : GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 2,
//                   mainAxisSpacing: 2,
//                 ),
//                 itemCount: _selectedMedia.length + (_selectedMedia.length < 10 ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index < _selectedMedia.length) {
//                     return Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.file(
//                           File(_selectedMedia[index].path),
//                           fit: BoxFit.cover,
//                         ),
//                         Positioned(
//                           top: 5,
//                           right: 5,
//                           child: GestureDetector(
//                             onTap: () => setState(() => _selectedMedia.removeAt(index)),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.black54,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(Icons.close, size: 18, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return GestureDetector(
//                       onTap: _pickMedia,
//                       child: Container(
//                         color: Colors.grey[200],
//                         child: Icon(Icons.add, size: 30, color: Colors.grey[600]),
//                       ),
//                     );
//                   }
//                 },
//               ),
//       ),
//     );
//   }

//   Widget _buildTagInput() {
//     return TextField(
//       controller: _tagController,
//       decoration: InputDecoration(
//         hintText: 'Ajouter un tag...',
//         prefixText: '#',
//         suffixIcon: IconButton(
//           icon: Icon(Icons.add),
//           onPressed: _addTag,
//         ),
//       ),
//       onSubmitted: (_) => _addTag(),
//     );
//   }

//   Widget _buildTagChips() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 4,
//       children: _selectedTags.map((tag) => Chip(
//         label: Text('#$tag'),
//         deleteIcon: Icon(Icons.close, size: 16),
//         onDeleted: () => _removeTag(tag),
//       )).toList(),
//     );
//   }

//   Widget _buildSuggestedTags() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 4,
//       children: _tagSuggestions.where((tag) => !_selectedTags.contains(tag)).map((tag) => ActionChip(
//         label: Text('#$tag'),
//         onPressed: () => setState(() => _selectedTags.add(tag)),
//       )).toList(),
//     );
//   }

//   Widget _buildPrivacySelector() {
//     return ListTile(
//       leading: Icon(Icons.privacy_tip, color: Colors.blue),
//       title: Text('Confidentialité'),
//       subtitle: Text(_privacy == 'Public' ? 'Visible par tous' : 'Amis seulement'),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (context) => Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile(
//                 title: Text('Public'),
//                 value: 'Public',
//                 groupValue: _privacy,
//                 onChanged: (value) => setState(() {
//                   _privacy = value!;
//                   Navigator.pop(context);
//                 }),
//               ),
//               RadioListTile(
//                 title: Text('Amis seulement'),
//                 value: 'Amis',
//                 groupValue: _privacy,
//                 onChanged: (value) => setState(() {
//                   _privacy = value!;
//                   Navigator.pop(context);
//                 }),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBottomBar() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         border: Border(top: BorderSide(color: Colors.grey[200]!))),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildBottomButton(Icons.photo_library, 'Médias', _pickMedia),
//           _buildBottomButton(Icons.tag, 'Tags', () {}),
//           _buildBottomButton(Icons.location_on, 'Lieu', () {}),
//           _buildBottomButton(Icons.more_horiz, 'Plus', () {}),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomButton(IconData icon, String label, VoidCallback onPressed) {
//     return TextButton.icon(
//       icon: Icon(icon, size: 24),
//       label: Text(label),
//       onPressed: onPressed,
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kongossa/model/user_model.dart';
// import 'package:kongossa/service/post_service.dart';
// import 'package:kongossa/service/storage_service.dart';
// import 'package:provider/provider.dart';

// class AddPostScreen extends StatefulWidget {
//   @override
//   _AddPostScreenState createState() => _AddPostScreenState();
// }

// class _AddPostScreenState extends State<AddPostScreen> {
//   final PostService _postService = PostService();
//   final StorageService _storageService = StorageService();
//   final TextEditingController _captionController = TextEditingController();
//   final TextEditingController _tagController = TextEditingController();

//   List<XFile> _selectedMedia = [];
//   List<String> _selectedTags = [];
//   String _privacy = 'public';
//   bool _isLoading = false;

//   Future<void> _submitPost() async {
//     final user = Provider.of<UserModel?>(context, listen: false);
//     if (user == null || _selectedMedia.isEmpty) return;
    
//     setState(() => _isLoading = true);

//     try {
//       final mediaUrls = await _storageService.uploadMediaFiles(
//         userId: user.uid,
//         files: _selectedMedia,
//         folderName: 'posts',
//       );

//       await _postService.createPost(
//         userId: user.uid,
//         caption: _captionController.text,
//         mediaUrls: mediaUrls,
//         tags: _selectedTags,
//         privacy: _privacy,
//       );

//       Navigator.pop(context, true);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erreur: ${e.toString()}')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   final List<String> _tagSuggestions = [
//     'voyage',
//     'food',
//     'art',
//     'techno',
//     'mode',
//     'fitness',
//     'musique',
//     'photographie'
//   ];

//   Future<void> _pickMedia() async {
//     final pickedFiles = await ImagePicker().pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() => _selectedMedia.addAll(pickedFiles));
//     }
//   }

//   void _addTag() {
//     if (_tagController.text.trim().isNotEmpty) {
//       final newTag =
//           _tagController.text.trim().replaceAll(' ', '_').toLowerCase();
//       if (!_selectedTags.contains(newTag)) {
//         setState(() => _selectedTags.add(newTag));
//       }
//       _tagController.clear();
//     }
//   }

//   void _removeTag(String tag) {
//     setState(() => _selectedTags.remove(tag));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserModel>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: _buildBody(user),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       title: Text('Nouveau Post', style: TextStyle(color: Colors.black)),
//       centerTitle: true,
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         icon: Icon(Icons.close, color: Colors.black),
//         onPressed: () => Navigator.pop(context),
//       ),
//       actions: [
//         TextButton(
//           onPressed: _selectedMedia.isNotEmpty ? _submitPost : null,
//           child: _isLoading
//               ? CircularProgressIndicator(color: Colors.blue)
//               : Text('Partager', style: TextStyle(color: Colors.blue)),
//         ),
//       ],
//     );
//   }

//   Widget _buildBody(UserModel user) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildAuthorSection(user),
//           SizedBox(height: 20),
//           _buildCaptionInput(),
//           SizedBox(height: 20),
//           _buildMediaGrid(),
//           SizedBox(height: 20),
//           _buildTagInput(),
//           _buildTagChips(),
//           SizedBox(height: 10),
//           _buildSuggestedTags(),
//           SizedBox(height: 20),
//           _buildPrivacySelector(),
//         ],
//       ),
//     );
//   }

//   Widget _buildAuthorSection(UserModel user) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundImage: NetworkImage(user.profileImageUrl),
//         ),
//         SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(user.username, style: TextStyle(fontWeight: FontWeight.bold)),
//             DropdownButton<String>(
//               value: _privacy,
//               items: [
//                 DropdownMenuItem(
//                   value: 'Public',
//                   child: Row(
//                     children: [
//                       Icon(Icons.public, size: 16),
//                       SizedBox(width: 5),
//                       Text('Public'),
//                     ],
//                   ),
//                 ),
//                 DropdownMenuItem(
//                   value: 'Amis',
//                   child: Row(
//                     children: [
//                       Icon(Icons.people, size: 16),
//                       SizedBox(width: 5),
//                       Text('Amis seulement'),
//                     ],
//                   ),
//                 ),
//               ],
//               onChanged: (value) => setState(() => _privacy = value!),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildCaptionInput() {
//     return TextField(
//       controller: _captionController,
//       maxLines: 5,
//       minLines: 1,
//       decoration: InputDecoration(
//         hintText: 'Quoi de neuf ?',
//         border: InputBorder.none,
//       ),
//     );
//   }

//   Widget _buildMediaGrid() {
//     return GestureDetector(
//       onTap: _pickMedia,
//       child: Container(
//         height: 200,
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey[300]!),
//         ),
//         child: _selectedMedia.isEmpty
//             ? Center(
//                 child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
//                   Text('Ajouter des médias',
//                       style: TextStyle(color: Colors.grey)),
//                 ],
//               ))
//             : GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 2,
//                   mainAxisSpacing: 2,
//                 ),
//                 itemCount: _selectedMedia.length +
//                     (_selectedMedia.length < 10 ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   if (index < _selectedMedia.length) {
//                     return Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.file(
//                           File(_selectedMedia[index].path),
//                           fit: BoxFit.cover,
//                         ),
//                         Positioned(
//                           top: 5,
//                           right: 5,
//                           child: GestureDetector(
//                             onTap: () =>
//                                 setState(() => _selectedMedia.removeAt(index)),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.black54,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(Icons.close,
//                                   size: 18, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return GestureDetector(
//                       onTap: _pickMedia,
//                       child: Container(
//                         color: Colors.grey[200],
//                         child:
//                             Icon(Icons.add, size: 30, color: Colors.grey[600]),
//                       ),
//                     );
//                   }
//                 },
//               ),
//       ),
//     );
//   }

//   Widget _buildTagInput() {
//     return TextField(
//       controller: _tagController,
//       decoration: InputDecoration(
//         hintText: 'Ajouter un tag...',
//         prefixText: '#',
//         suffixIcon: IconButton(
//           icon: Icon(Icons.add),
//           onPressed: _addTag,
//         ),
//       ),
//       onSubmitted: (_) => _addTag(),
//     );
//   }

//   Widget _buildTagChips() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 4,
//       children: _selectedTags
//           .map((tag) => Chip(
//                 label: Text('#$tag'),
//                 deleteIcon: Icon(Icons.close, size: 16),
//                 onDeleted: () => _removeTag(tag),
//               ))
//           .toList(),
//     );
//   }

//   Widget _buildSuggestedTags() {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 4,
//       children: _tagSuggestions
//           .where((tag) => !_selectedTags.contains(tag))
//           .map((tag) => ActionChip(
//                 label: Text('#$tag'),
//                 onPressed: () => setState(() => _selectedTags.add(tag)),
//               ))
//           .toList(),
//     );
//   }

//   Widget _buildPrivacySelector() {
//     return ListTile(
//       leading: Icon(Icons.privacy_tip, color: Colors.blue),
//       title: Text('Confidentialité'),
//       subtitle:
//           Text(_privacy == 'Public' ? 'Visible par tous' : 'Amis seulement'),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (context) => Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile(
//                 title: Text('Public'),
//                 value: 'Public',
//                 groupValue: _privacy,
//                 onChanged: (value) => setState(() {
//                   _privacy = value!;
//                   Navigator.pop(context);
//                 }),
//               ),
//               RadioListTile(
//                 title: Text('Amis seulement'),
//                 value: 'Amis',
//                 groupValue: _privacy,
//                 onChanged: (value) => setState(() {
//                   _privacy = value!;
//                   Navigator.pop(context);
//                 }),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBottomBar() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//           border: Border(top: BorderSide(color: Colors.grey[200]!))),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildBottomButton(Icons.photo_library, 'Médias', () {}),
//           _buildBottomButton(Icons.tag, 'Tags', () {}),
//           _buildBottomButton(Icons.location_on, 'Lieu', () {}),
//           _buildBottomButton(Icons.more_horiz, 'Plus', () {}),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomButton(
//       IconData icon, String label, VoidCallback onPressed) {
//     return TextButton.icon(
//       icon: Icon(icon, size: 24),
//       label: Text(label),
//       onPressed: onPressed,
//     );
//   }
// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_size.dart';

import '../config/app_font.dart';
import '../config/app_string.dart';
import '../controller/auth_controller.dart';
import '../controller/new_post/createpost_controller.dart';
import '../model/user_model.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final authC = Get.put(AuthController());
    final createC = Get.put(CreatePostController());

    return Obx(() {
      final user = authC.user.value;
      return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          title: const Text(
              "New Post",
              style: TextStyle(
                fontSize: AppSize.appSize20,
                fontWeight: FontWeight.w600,
                fontFamily: AppFont.appFontSemiBold,
                color: AppColor.secondaryColor,
              ),
            ),
          // centerTitle: true,
         backgroundColor: AppColor.backgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.close, color: AppColor.secondaryColor),
            onPressed: () => Get.back(),
          ),
          actions: [
            TextButton(
              onPressed: (createC.selectedMedia.isNotEmpty && !createC.isLoading.value && user != null)
                  ? () => createC.submitPost(user.uid)
                  : null,
              child: createC.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.blue)
                  : const Text('Share', style: TextStyle(color: AppColor.secondaryColor, fontSize: AppSize.appSize16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        body: user == null
            ? const Center(child: Text('User not connected'))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAuthorSection(user, createC),
                    const SizedBox(height: 20),
                    _buildCaptionInput(createC),
                    const SizedBox(height: 20),
                    _buildMediaGrid(createC),
                    const SizedBox(height: 20),
                    _buildTagInput(createC),
                    _buildTagChips(createC),
                    const SizedBox(height: 10),
                    _buildSuggestedTags(createC),
                    const SizedBox(height: 20),
                    _buildPrivacySelector(createC),
                  ],
                ),
              ),
        // bottomNavigationBar: _buildBottomBar(),
      );
    });
  }

  Widget _buildAuthorSection(UserModel user, CreatePostController c) {
    return Row(
      children: [
        CircleAvatar(radius: 20, backgroundImage: NetworkImage(user.profileImageUrl)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.username, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.secondaryColor)),
            Obx(() => DropdownButton<String>(
                  value: c.privacy.value,
               
                  underline: Container(height: 1, color: Colors.grey[300]),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColor.secondaryColor),
                  items: const [
                    DropdownMenuItem(value: 'Public', child: Row(children: [Icon(Icons.public, size:16), SizedBox(width:5), Text('Public',)])),
                    DropdownMenuItem(value: 'Amis', child: Row(children: [Icon(Icons.people, size:16), SizedBox(width:5), Text('Amis seulement',)])),
                  ],
                  onChanged: (v) => c.privacy.value = v!,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildCaptionInput(CreatePostController c) {
    return TextField(
      controller: c.captionController,
      maxLines: 5,
      minLines: 1,
      decoration: const InputDecoration(
        hintText: 'Quoi de neuf ?',
        hintStyle: TextStyle(color: AppColor.secondaryColor),
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildMediaGrid(CreatePostController c) {
    return GestureDetector(
      onTap: c.pickMedia,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Obx(() => c.selectedMedia.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate, size:50, color:Colors.grey),
                    Text('Ajouter des médias', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: c.selectedMedia.length + (c.selectedMedia.length < 10 ? 1 : 0),
                itemBuilder: (ctx, idx) {
                  if (idx < c.selectedMedia.length) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(File(c.selectedMedia[idx].path), fit: BoxFit.cover),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => c.selectedMedia.removeAt(idx),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size:18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onTap: c.pickMedia,
                      child: Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.add, size:30, color: Colors.grey),
                      ),
                    );
                  }
                },
              )),
      ),
    );
  }

  Widget _buildTagInput(CreatePostController c) {
    return TextField(
      controller: c.tagController,
      decoration: InputDecoration(
        hintText: 'Ajouter un tag...',
        prefixText: '#',
        suffixIcon: IconButton(icon: const Icon(Icons.add), onPressed: c.addTag),
      ),
      onSubmitted: (_) => c.addTag(),
    );
  }

  Widget _buildTagChips(CreatePostController c) {
    return Obx(() => Wrap(
          spacing: 8,
          runSpacing: 4,
          children: c.selectedTags.map((t) => Chip(
                label: Text('#$t'),
                deleteIcon: const Icon(Icons.close, size:16),
                onDeleted: () => c.removeTag(t),
              )).toList(),
        ));
  }

  Widget _buildSuggestedTags(CreatePostController c) {
    return Obx(() => Wrap(
          spacing: 8,
          runSpacing: 4,
          children: c.tagSuggestions.where((t) => !c.selectedTags.contains(t)).map((t) => ActionChip(
                label: Text('#$t'),
                onPressed: () => c.selectedTags.add(t),
              )).toList(),
        ));
  }

  Widget _buildPrivacySelector(CreatePostController c) {
    return ListTile(
      leading: const Icon(Icons.privacy_tip, color: Colors.blue),
      title: const Text('Confidentialité', style: TextStyle(color: AppColor.secondaryColor)),
      subtitle: Obx(() => Text(c.privacy.value == 'Public' ? 'Visible par tous' : 'Amis seulement', style: const TextStyle(color: AppColor.secondaryColor))),
      trailing: const Icon(Icons.arrow_forward_ios, size:16),
      onTap: () {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => RadioListTile(
                      value: 'Public',
                      groupValue: c.privacy.value,
                      title: const Text('Public'),
                      onChanged: (v) => c.privacy.value = v!,
                    )),
                Obx(() => RadioListTile(
                      value: 'Amis',
                      groupValue: c.privacy.value,
                      title: const Text('Amis seulement'),
                      onChanged: (v) => c.privacy.value = v!,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _buildBottomBar() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical:8),
  //     decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200]!))),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         _bottomButton(Icons.photo_library, 'Médias'),
  //         _bottomButton(Icons.tag, 'Tags'),
  //         _bottomButton(Icons.location_on, 'Lieu'),
  //         _bottomButton(Icons.more_horiz, 'Plus'),

  //       ],
  //     ),
  //   );
  // }

  Widget _bottomButton(IconData icon, String label) {
    return TextButton.icon(
      icon: Icon(icon, size:24),
      label: Text(label),
      onPressed: () {},
    );
  }
}