// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kongossa/config/app_color.dart';
// import 'package:kongossa/config/app_image.dart';
// import 'package:kongossa/config/app_size.dart';
// import 'package:kongossa/routes/app_routes.dart';
// import '../../config/app_string.dart';
// import '../../widget/app_button.dart';

// class WelcomeView extends StatelessWidget {
//   const WelcomeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.backgroundColor,
//         body: _body(context),
//       ),
//     );
//   }

//   //Welcome content
//   _body(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           flex: AppSize.size8,
//           child: Stack(
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: Image.asset(
//                   AppImage.welcome,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: AppSize.appSize106,
//                 left: AppSize.appSize16,
//                 child: Image.asset(
//                   AppImage.welcomeString,
//                   width: AppSize.appSize245,
//                   height: AppSize.appSize245,
//                   fit: BoxFit.scaleDown,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           flex: AppSize.size1,
//           child: Container(
//             padding: const EdgeInsets.only(
//               left: AppSize.appSize20,
//               right: AppSize.appSize20,
//             ),
//             child: Center(
//               child: AppButton(
//                 onPressed: () {
//                   Get.offAllNamed(AppRoutes.bottomBarView);
//                 },
//                 text: AppString.buttonTextGetStarted,
//                 backgroundColor: AppColor.primaryColor,
//                 margin: EdgeInsets.zero,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kongossa/routes/app_routes.dart';

// class WelcomeView extends StatefulWidget {
//   const WelcomeView({Key? key}) : super(key: key);

//   @override
//   _WelcomeViewState createState() => _WelcomeViewState();
// }

// class _WelcomeViewState extends State<WelcomeView> {
//   final Map<String, bool> categories = {
//     'Actualités': false,
//     'Sport': false,
//     'Technologie': false,
//     'Cinéma & Séries': false,
//     'Musique': false,
//     'Art & Design': false,
//     'Mode': false,
//     'Voyage': false,
//     'Cuisine': false,
//     'Santé & Bien-être': false,
//     'Finance': false,
//     'Éducation': false,
//     'Science': false,
//     'Jeux vidéo': false,
//     'Livres': false,
//     'Automobile': false,
//     'Photographie': false,
//     'Nature': false,
//     'Politique': false,
//     'Histoire': false,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         // leading: IconButton(
//         //   icon: const Icon(Icons.arrow_back, color: Colors.black),
//         //   onPressed: () => Get.back(),
//         // ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Sélectionnez vos centres d\'intérêt',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Choisissez au moins 3 catégories pour personnaliser votre expérience',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.count(
//               padding: const EdgeInsets.all(16),
//               crossAxisCount: 2,
//               childAspectRatio: 3,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               children: categories.keys.map((category) {
//                 return _buildCategoryChip(category);
//               }).toList(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: _validateSelection,
//                 child: const Text('CONTINUER', style: TextStyle(fontSize: 16)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryChip(String category) {
//     return ChoiceChip(
//       label: Text(category),
//       selected: categories[category]!,
//       onSelected: (selected) {
//         setState(() {
//           categories[category] = selected;
//         });
//       },
//       selectedColor: Colors.black,
//       labelStyle: TextStyle(
//         color: categories[category]! ? Colors.white : Colors.black,
//       ),
//       side: const BorderSide(color: Colors.black),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     );
//   }

//   void _validateSelection() {
//     final selectedCount = categories.values.where((v) => v).length;
    
//     if (selectedCount < 3) {
//       Get.snackbar(
//         'Sélection incomplète',
//         'Veuillez sélectionner au moins 3 catégories',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.black,
//         colorText: Colors.white,
//       );
//     } else {
//       final selectedCategories = categories.entries
//           .where((entry) => entry.value)
//           .map((entry) => entry.key)
//           .toList();
      
//       Get.offAllNamed(
//         AppRoutes.bottomBarView,
//         arguments: selectedCategories,
//       );
//     }
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kongossa/routes/app_routes.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final Map<String, bool> categories = {
    'Actualités': false,
    'Sport': false,
    'Technologie': false,
    'Cinéma & Séries': false,
    'Musique': false,
    'Art & Design': false,
    'Mode': false,
    'Voyage': false,
    'Cuisine': false,
    'Santé & Bien-être': false,
    'Finance': false,
    'Éducation': false,
    'Science': false,
    'Jeux vidéo': false,
    'Livres': false,
    'Automobile': false,
    'Photographie': false,
    'Nature': false,
    'Politique': false,
    'Histoire': false,
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserSelections();
  }

  Future<void> _loadUserSelections() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('user_interests')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final savedInterests = List<String>.from(doc.data()?['interests'] ?? []);
        setState(() {
          for (var interest in savedInterests) {
            if (categories.containsKey(interest)) {
              categories[interest] = true;
            }
          }
        });
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les préférences');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSelections() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final selected = categories.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      await FirebaseFirestore.instance
          .collection('user_interests')
          .doc(user.uid)
          .set({
            'interests': selected,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

      Get.offAllNamed(
        AppRoutes.bottomBarView,
        arguments: selected,
      );
    } catch (e) {
      Get.snackbar('Erreur', 'Échec de la sauvegarde');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sélectionnez vos centres d\'intérêt',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choisissez au moins 3 catégories pour personnaliser votre expérience',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: categories.keys.map((category) {
                return _buildCategoryChip(category);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateSelection,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('CONTINUER', style: TextStyle(fontSize: 16)),
            ),
          ),
      )],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return ChoiceChip(
      label: Text(category),
      selected: categories[category]!,
      onSelected: (selected) {
        setState(() {
          categories[category] = selected;
        });
      },
      selectedColor: Colors.black,
      labelStyle: TextStyle(
        color: categories[category]! ? Colors.white : Colors.black,
      ),
      side: const BorderSide(color: Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _validateSelection() {
    final selectedCount = categories.values.where((v) => v).length;
    
    if (selectedCount < 3) {
      Get.snackbar(
        'Sélection incomplète',
        'Veuillez sélectionner au moins 3 catégories',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } else {
      _saveSelections();
    }
  }
}