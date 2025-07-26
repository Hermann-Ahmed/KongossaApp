import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kongossa/controller/auth_controller.dart';
import 'package:kongossa/model/status.dart';
import 'package:kongossa/model/user_model.dart';
import 'package:kongossa/service/storage_service.dart';

class StatusController extends GetxController {
  // --- DÉPENDANCES INJECTÉES ---
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  final authController = Get.find<AuthController>();

  // --- CONSTANTES POUR LA ROBUSTESSE ---
  static const String _usersCollection = 'users';
  static const String _userStatusesCollection = 'user_statuses';
  static const String _statusesSubCollection = 'statuses';

  // --- CHAMPS FIRESTORE ---
  static const String _fieldUserId = 'userId';
  static const String _fieldVisibility = 'visibility';
  static const String _fieldExpiresAt = 'expiresAt';
  static const String _fieldCreatedAt = 'createdAt';

  // --- LISTES OBSERVABLES ---
  final RxList<Status> allStatus = <Status>[].obs;
  final RxList<Status> userStatus = <Status>[].obs;
  final RxList<Status> publicStatus = <Status>[].obs;

  // --- COMPUTED OBSERVABLES FOR UI ---
  final RxMap<String, List<Status>> groupedPublicStatusByUser =
      <String, List<Status>>{}.obs;
  final RxList<String> publicStatusUserIds = <String>[].obs;

  // --- ÉTATS DE CHARGEMENT ---
  final RxBool isLoading = false.obs;
  final RxBool isCreating = false.obs;
  final RxBool isDeleting = false.obs;

  // --- SOUSCRIPTIONS AUX STREAMS ---
  StreamSubscription<QuerySnapshot>? _allStatusSubscription;
  StreamSubscription<QuerySnapshot>? _userStatusSubscription;
  StreamSubscription<QuerySnapshot>? _publicStatusSubscription;

  // --- ÉTAT POUR L'ÉCRAN DE CRÉATION ---
  final RxList<XFile> filesToUpload = <XFile>[].obs;
  final RxString newStatusVisibility = 'public'.obs; // Visibilité par défaut

  // --- ID DE L'UTILISATEUR COURANT (injecté) ---
  String? currentUserId;

  // --- CACHE ---
  final RxMap<String, UserModel> userInfoCache = <String, UserModel>{}.obs;

  @override
  void onInit() {
    super.onInit();
    print("userId: ${authController.user.value?.uid}");
    // Only initialize user if authController.user.value is not null
    if (authController.user.value?.uid != null) {
      initializeUser(authController.user.value!.uid);
    } else {
      // Listen to auth changes to initialize user
      ever(authController.user, (UserModel? user) {
        if (user != null && currentUserId == null) {
          initializeUser(user.uid);
        }
      });
    }

    // Reactive grouping of public statuses
    ever(publicStatus, (_) => _groupPublicStatuses());
  }

  @override
  void onClose() {
    // Annuler toutes les souscriptions pour éviter les fuites de mémoire
    _allStatusSubscription?.cancel();
    _userStatusSubscription?.cancel();
    _publicStatusSubscription?.cancel();
    super.onClose();
  }

  /// Initialise le contrôleur avec l'ID utilisateur et démarre les écoutes.
  void initializeUser(String userId) {
    currentUserId = userId;
    startRealtimeListeners();
  }

  /// Sélectionne plusieurs images depuis la galerie.
  Future<void> pickImages() async {
    try {
      final List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        filesToUpload.addAll(pickedFiles);
      }
    } catch (e) {
      _handleError("sélection d'images", e);
    }
  }

  /// Retire une image de la liste de prévisualisation.
  void removeImage(XFile file) {
    filesToUpload.remove(file);
  }

  /// Réinitialise le formulaire de création.
  void clearCreationForm() {
    filesToUpload.clear();
    newStatusVisibility.value = 'public';
  }

  /// Démarre toutes les écoutes en temps réel.
  void startRealtimeListeners() {
    if (currentUserId == null) return;
    listenToPublicStatus();
    listenToUserStatus(currentUserId!);
    // listenToAllStatus(); // À décommenter pour les rôles d'admin
  }

  /// Écoute les statuts publics et non expirés de tous les utilisateurs.
  void listenToPublicStatus() {
    _publicStatusSubscription?.cancel();
    _publicStatusSubscription = _firestore
        .collectionGroup(
            _statusesSubCollection) // Requête sur toutes les sous-collections 'statuses'
        .where(_fieldVisibility, isEqualTo: 'public')
        .where(_fieldExpiresAt, isGreaterThan: Timestamp.now())
        .orderBy(_fieldExpiresAt)
        .orderBy(_fieldCreatedAt, descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        publicStatus.value = snapshot.docs
            .map((doc) => Status.fromMap(
                doc.data()))
            .toList();
      },
      onError: (error) =>
          _handleError('récupération des statuts publics', error),
    );
  }

  /// Écoute les statuts d'un utilisateur spécifique.
  void listenToUserStatus(String userId) {
    _userStatusSubscription?.cancel();
    _userStatusSubscription = _firestore
        .collection(_userStatusesCollection)
        .doc(userId)
        .collection(_statusesSubCollection)
        .orderBy(_fieldCreatedAt, descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        userStatus.value = snapshot.docs
            .map((doc) => Status.fromMap(doc.data()))
            .toList();
      },
      onError: (error) =>
          _handleError('récupération des statuts utilisateur', error),
    );
  }

  /// Écoute tous les statuts (pour les administrateurs).
  void listenToAllStatus() {
    _allStatusSubscription?.cancel();
    _allStatusSubscription = _firestore
        .collectionGroup(_statusesSubCollection)
        .orderBy(_fieldCreatedAt, descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        allStatus.value = snapshot.docs
            .map((doc) => Status.fromMap(
                doc.data()))
            .toList();
      },
      onError: (error) =>
          _handleError('récupération de tous les statuts', error),
    );
  }

  /// Crée plusieurs statuts après avoir uploadé des fichiers.
  Future<bool> createStatusWithFiles() async {
    if (currentUserId == null) {
      _showErrorSnackbar('Utilisateur non connecté.');
      return false;
    }
    if (filesToUpload.isEmpty) {
      _showErrorSnackbar('Aucun fichier sélectionné.');
      return false;
    }

    isCreating.value = true;
    try {
      final urls = await _storageService.uploadMediaFiles(
        userId: currentUserId!,
        files: filesToUpload, // Utilise la liste du contrôleur
        folderName: '$_userStatusesCollection/$currentUserId',
      );

      if (urls.isEmpty) {
        _showErrorSnackbar("Échec de l'upload des fichiers.");
        return false; // Ne pas continuer
      }

      final batch = _firestore.batch();
      final now = DateTime.now();
      final expiration = now.add(const Duration(hours: 24));

      for (final url in urls) {
        final docRef = _firestore
            .collection(_userStatusesCollection)
            .doc(currentUserId!)
            .collection(_statusesSubCollection)
            .doc();

        final newStatus = Status(
          id: docRef.id,
          userId: currentUserId!,
          type: 'image', // ou à rendre dynamique
          contentUrl: url,
          createdAt: now,
          expiresAt: expiration,
          visibility:
              newStatusVisibility.value, // Utilise la valeur du contrôleur
        );
        batch.set(docRef, newStatus.toMap());
      }

      await batch.commit();

      Get.snackbar('Succès', '${urls.length} statut(s) créé(s) avec succès.');
      clearCreationForm(); // Nettoyer le formulaire
      return true;
    } catch (e) {
      _handleError('création du statut', e);
      return false;
    } finally {
      isCreating.value = false;
    }
  }

  /// Met à jour un statut existant.
  Future<bool> updateStatus(
      String userId, String statusId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection(_userStatusesCollection)
          .doc(userId)
          .collection(_statusesSubCollection)
          .doc(statusId)
          .update(updates);
      Get.snackbar('Succès', 'Statut mis à jour avec succès.');
      return true;
    } catch (e) {
      _handleError('mise à jour du statut', e);
      return false;
    }
  }

  /// Supprime un statut.
  Future<bool> deleteStatus(String userId, String statusId) async {
    isDeleting.value = true;
    try {
      // Optionnel: Supprimer le fichier associé sur Firebase Storage ici.
      // final status = await getStatusById(userId, statusId);
      // if (status != null) { await _storageService.deleteFile(status.contentUrl); }

      await _firestore
          .collection(_userStatusesCollection)
          .doc(userId)
          .collection(_statusesSubCollection)
          .doc(statusId)
          .delete();
      Get.snackbar('Succès', 'Statut supprimé avec succès.');
      return true;
    } catch (e) {
      _handleError('suppression du statut', e);
      return false;
    } finally {
      isDeleting.value = false;
    }
  }

  /// Nettoie les statuts expirés de tous les utilisateurs.
  /// NOTE: Pour une application à grande échelle, préférez une Cloud Function planifiée.
  Future<void> cleanupExpiredStatus() async {
    try {
      final snapshot = await _firestore
          .collectionGroup(_statusesSubCollection)
          .where(_fieldExpiresAt, isLessThan: Timestamp.now())
          .get();

      if (snapshot.docs.isEmpty) return;

      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      Get.snackbar('Nettoyage',
          '${snapshot.docs.length} statut(s) expiré(s) supprimé(s).');
    } catch (e) {
      _handleError('nettoyage des statuts', e);
    }
  }

  /// Récupère les informations d'un utilisateur (avec cache).
  Future<UserModel?> getUserInfo(String userId) async {
    if (userInfoCache.containsKey(userId)) {
      return userInfoCache[userId];
    }
    try {
      final doc =
          await _firestore.collection(_usersCollection).doc(userId).get();
      if (doc.exists) {
        final user = UserModel.fromFirestore(doc);
        userInfoCache[userId] = user;
        return user;
      }
      return null;
    } catch (e) {
      _handleError("récupération des informations de l'utilisateur", e);
      return null;
    }
  }

  // --- MÉTHODES HELPER ---

  /// Vérifie si le statut appartient à l'utilisateur courant.
  bool isOwner(Status status) => status.userId == currentUserId;

  bool isStatusValid(Status status) {
    return status.expiresAt.isAfter(DateTime.now());
  }

  /// Change la visibilité d'un statut.
  Future<bool> changeStatusVisibility(
      String userId, String statusId, String newVisibility) async {
    return await updateStatus(
        userId, statusId, {_fieldVisibility: newVisibility});
  }

  /// Méthode privée pour la gestion centralisée des erreurs.
  void _handleError(String context, dynamic error) {
    String errorMessage = "Erreur lors de $context.";
    if (error is FirebaseException) {
      errorMessage =
          "Erreur Firebase ($context): ${error.message} (Code: ${error.code})";
    } else {
      errorMessage = "Erreur inattendue ($context): $error";
    }
    _showErrorSnackbar(errorMessage);
  }

  /// Affiche une snackbar d'erreur.
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Erreur',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
    );
  }

  void _groupPublicStatuses() {
    final Map<String, List<Status>> tempMap = {};
    for (Status status in publicStatus) {
      // This is already correctly filtering public statuses
      if (isStatusValid(status)) {
        if (tempMap.containsKey(status.userId)) {
          tempMap[status.userId]!.add(status);
        } else {
          tempMap[status.userId] = [status];
        }
      }
    
    print("tempMap: $tempMap");
    }
    groupedPublicStatusByUser.value = tempMap; // Update the RxMap

    // Now, prepare the ordered list of user IDs
    final List<String> userIds = tempMap.keys.toList();
    if (currentUserId != null && userIds.contains(currentUserId!)) {
      userIds.remove(currentUserId!); // Remove to re-insert at the beginning
      userIds.insert(0, currentUserId!);
    }
    publicStatusUserIds.value = userIds; // Update the RxList
  }
}
