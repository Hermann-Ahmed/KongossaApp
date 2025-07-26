import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/model/status.dart';
import 'package:kongossa/model/user_model.dart';

class HomeController extends GetxController {
  final RxMap<String, List<Status>> userStatuses = <String, List<Status>>{}.obs;
  final RxMap<String, UserModel> userInfoMap = <String, UserModel>{}.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String userStatusCollection = 'user_statuses';

  Rx<int> selectedLabelIndex = Rx<int>(0);
  RxDouble progress = 0.0.obs;
  RxBool isLiked = false.obs;
  RxBool isLiked1 = false.obs;
  RxBool isLiked2 = false.obs;
  RxBool isLiked3 = false.obs;
  RxBool isLiked4 = false.obs;
  RxBool isLiked5 = false.obs;
  RxBool isLiked6 = false.obs;

  void startAnimation() async {
    await Future.delayed(const Duration(seconds: AppSize.size2));
    Get.back();
  }

  HomeController() {
    selectLabel(0);
  }

  bool isLabelSelected(int index) {
    return selectedLabelIndex.value == index;
  }

  void selectLabel(int index) {
    selectedLabelIndex.value = index;
    update();
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }

  void toggleLike1() {
    isLiked1.value = !isLiked1.value;
  }

  void toggleLike2() {
    isLiked2.value = !isLiked2.value;
  }

  void toggleLike3() {
    isLiked3.value = !isLiked3.value;
  }

  void toggleLike4() {
    isLiked4.value = !isLiked4.value;
  }

  void toggleLike5() {
    isLiked5.value = !isLiked5.value;
  }

  void toggleLike6() {
    isLiked6.value = !isLiked6.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Charger les statuts des utilisateurs au démarrage
    loadStatuses();
  }

  Future<void> loadStatuses() async {
    try {
      final userCollections =
          await firestore.collection(userStatusCollection).get();

      print("User collections found: ${userCollections.docs.length}");

      for (var userDoc in userCollections.docs) {
        final userId = userDoc.id;

        // Récupérer les statuts de ce user
        final statusSnapshots = await firestore
            .collection(userStatusCollection)
            .doc(userId)
            .collection('statuses')
            .orderBy('createdAt', descending: true)
            .get();

        final statusList = statusSnapshots.docs
            .map((doc) => Status.fromMap(doc.data()))
            .toList();

        print("Status for user $userId: ${statusList.length} found");

        if (statusList.isNotEmpty) {
          userStatuses[userId] = statusList;

          // Charger les infos utilisateur
          final userSnap =
              await firestore.collection('users').doc(userId).get();

          if (userSnap.exists) {
            userInfoMap[userId] = UserModel.fromFirestore(userSnap);
          }
        }
      }

      print("User statuses loaded: ${userStatuses.length}");
    } catch (e) {
      print("Erreur lors du chargement des statuts: $e");
    }
  }

// Doit contenir la liste des gens qui ont mis des stories
  RxList<String> storyList = [
    AppImage.myStory,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
    AppImage.story1,
    AppImage.story2,
    AppImage.story3,
  ].obs;

  // Doit contenir la liste des noms des gens qui ont mis des stories
  RxList<String> storyIDList = [
    AppString.yourStory,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
    AppString.sabsa01,
    AppString.blueBouy,
    AppString.wagglesCo,
  ].obs;

  RxList<String> labelsList = [
    AppString.trending,
    AppString.forMe,
    AppString.following,
    AppString.recommend,
  ].obs;

  RxList<String> reelsList = [
    AppImage.reel1,
    AppImage.reel2,
    AppImage.reel1,
    AppImage.reel2,
    AppImage.reel1,
    AppImage.reel2,
    AppImage.reel1,
    AppImage.reel2,
  ].obs;
}
