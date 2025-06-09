// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/controller/profile/profile_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/routes/app_routes.dart';
import 'package:kongossa/views/profile/tabs/profile_comments_tab_view.dart';
import 'package:kongossa/views/profile/tabs/profile_posts_tab_view.dart';
import 'package:kongossa/views/profile/tabs/profile_reels_tab_view.dart';
import 'package:kongossa/views/profile/tabs/profile_tags_tab_view.dart';
import 'package:kongossa/views/widget/profile/profile_action_bottom_sheet.dart';
import '../../../config/app_icon.dart';
import '../../../config/app_size.dart';
import '../../model/highlight_model.dart';

class ProfileView extends StatelessWidget {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  ProfileController profileController = Get.put(ProfileController());
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _appBar(context),
      body: _body(),
    );
  }

  //All post content
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('Aucune donnée trouvée.'));
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.only(left: AppSize.appSize5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: userData['username'] != null
                    ? Text(
                        userData['username'],
                        style: TextStyle(
                          fontSize: AppSize.appSize20,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      )
                    : Text(
                        AppString.eleanorPenaID,
                        style: TextStyle(
                          fontSize: AppSize.appSize20,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
              ),
            );
          }),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: AppSize.appSize10,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize16
                    : AppSize.appSize0,
          ),
          child: GestureDetector(
            onTap: () {
              profileActionBottomSheet(context);
            },
            child: Container(
              width: AppSize.appSize40,
              color: AppColor.backgroundColor,
              child: Center(
                child: Image.asset(
                  AppIcon.info,
                  height: AppSize.appSize14,
                  width: AppSize.appSize3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _body() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize35,
                    left: AppSize.appSize20,
                    right: AppSize.appSize20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: AppSize.appSize14),
                            child: Row(
                              children: [
                                //View story
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.storyWithMessageView);
                                  },
                                  child: Image.asset(
                                    AppImage.story2,
                                    width: AppSize.appSize82,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: AppSize.appSize50,
                                    margin: EdgeInsets.only(
                                      left: languageController
                                                  .selectedLanguageIndex
                                                  .value ==
                                              AppSize.size2
                                          ? AppSize.appSize8
                                          : AppSize.appSize30,
                                      right: languageController
                                                  .selectedLanguageIndex
                                                  .value ==
                                              AppSize.size2
                                          ? AppSize.appSize30
                                          : AppSize.appSize0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Posts
                                        _customPostFollowersFollowingCount(
                                            AppString.posts176,
                                            AppString.posts),
                                        //Followers
                                        _customPostFollowersFollowingCount(
                                            AppString.followers200k,
                                            AppString.followers),
                                        //Following
                                        _customPostFollowersFollowingCount(
                                            AppString.following1123,
                                            AppString.following),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return Center(
                                      child: Text('Aucune donnée trouvée.'));
                                }

                                final userData = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: AppSize.appSize4),
                                  child: userData['username'] != null ? Text(
                                    userData['username'],
                                    style: const TextStyle(
                                      fontSize: AppSize.appSize16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.appFontSemiBold,
                                      color: AppColor.secondaryColor,
                                    ),
                                  ) : const Text(
                                    AppString.eleanorPena,
                                    style: TextStyle(
                                      fontSize: AppSize.appSize16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.appFontSemiBold,
                                      color: AppColor.secondaryColor,
                                    ),
                                  ),
                                );
                              }),
                          const Text(
                            AppString.loremString5,
                            style: TextStyle(
                              fontSize: AppSize.appSize14,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFont.appFontRegular,
                              color: AppColor.secondaryColor,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: AppSize.appSize14),
                            child: SizedBox(
                              height: AppSize.appSize32,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.editProfileView);
                                    },
                                    child: Container(
                                      width: kIsWeb
                                          ? AppSize.appSize355
                                          : AppSize.appSize147,
                                      height: AppSize.appSize32,
                                      margin: EdgeInsets.only(
                                        right: AppSize.appSize8,
                                        left: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize8
                                            : AppSize.appSize0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppSize.appSize6),
                                        color: AppColor.cardBackgroundColor,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          AppString.buttonTextEditProfile,
                                          style: TextStyle(
                                            fontSize: AppSize.appSize14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: AppFont.appFontRegular,
                                            color: AppColor.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                          msg: AppString.profileShared,
                                          backgroundColor:
                                              AppColor.cardBackgroundColor,
                                          fontSize: AppSize.appSize14,
                                          textColor: AppColor.secondaryColor,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      },
                                      child: Container(
                                        width: AppSize.appSize147,
                                        height: AppSize.appSize32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.appSize6),
                                          color: AppColor.cardBackgroundColor,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            AppString.shareProfile,
                                            style: TextStyle(
                                              fontSize: AppSize.appSize14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                                  AppFont.appFontRegular,
                                              color: AppColor.secondaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Fluttertoast.showToast(
                                        msg: AppString.userAdded,
                                        backgroundColor:
                                            AppColor.cardBackgroundColor,
                                        fontSize: AppSize.appSize14,
                                        textColor: AppColor.secondaryColor,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                      );
                                    },
                                    child: Container(
                                      width: AppSize.appSize40,
                                      height: AppSize.appSize32,
                                      margin: EdgeInsets.only(
                                        left: AppSize.appSize8,
                                        right: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize8
                                            : AppSize.appSize0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppSize.appSize6),
                                        color: AppColor.cardBackgroundColor,
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          AppIcon.add,
                                          width: AppSize.appSize20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(
                            top: AppSize.appSize36, bottom: AppSize.appSize32),
                        child: Obx(() => Row(
                              children: [
                                _customHighlights(AppIcon.add3, AppString.add,
                                    () {
                                  final index =
                                      profileController.highlights.length + 1;
                                  profileController.highlights.add(
                                      HighlightItem(AppImage.highlight1,
                                          "Highlight $index"));
                                }),
                                _customHighlights(
                                    AppImage.highlight1, AppString.like, () {}),
                                _customHighlights(AppImage.highlight2,
                                    AppString.travel, () {}),
                                ...profileController.highlights
                                    .map((highlight) => _customHighlights(
                                            highlight.image, highlight.label,
                                            () {
                                          profileController.highlights
                                              .remove(highlight);
                                        }))
                                    .toList(),
                              ],
                            )),
                      ),
                      Obx(() {
                        return TabBar(
                          onTap: (val) {
                            profileController.selectedTabIndex.value = val;
                          },
                          controller: profileController.tabController,
                          dividerColor: AppColor.backgroundColor,
                          labelColor: AppColor.secondaryColor,
                          labelStyle: const TextStyle(
                            color: AppColor.secondaryColor,
                          ),
                          unselectedLabelColor: AppColor.text1Color,
                          indicatorColor: AppColor.secondaryColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: AppSize.appSizePoint7,
                          isScrollable: false,
                          tabs: [
                            Tab(
                              icon: Image.asset(
                                AppIcon.photos,
                                width: AppSize.appSize22,
                                color:
                                    profileController.selectedTabIndex.value ==
                                            0
                                        ? AppColor.secondaryColor
                                        : AppColor.text1Color,
                              ),
                            ),
                            Tab(
                              icon: Image.asset(
                                AppIcon.editComment,
                                width: AppSize.appSize22,
                                color:
                                    profileController.selectedTabIndex.value ==
                                            1
                                        ? AppColor.secondaryColor
                                        : AppColor.text1Color,
                              ),
                            ),
                            Tab(
                              icon: Image.asset(
                                AppIcon.reel,
                                width: AppSize.appSize22,
                                color:
                                    profileController.selectedTabIndex.value ==
                                            2
                                        ? AppColor.secondaryColor
                                        : AppColor.text1Color,
                              ),
                            ),
                            Tab(
                              icon: Image.asset(
                                AppIcon.tag,
                                width: AppSize.appSize22,
                                color:
                                    profileController.selectedTabIndex.value ==
                                            3
                                        ? AppColor.secondaryColor
                                        : AppColor.text1Color,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: profileController.tabController,
        children: [
          ProfilePostsTabView(),
          const ProfileCommentsTabView(),
          ProfileReelsTabView(),
          ProfileTagsTabView(),
        ],
      ),
    );
  }

  _customPostFollowersFollowingCount(String text1, String text2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: AppSize.appSize16,
            fontWeight: FontWeight.w600,
            fontFamily: AppFont.appFontSemiBold,
            color: AppColor.secondaryColor,
          ),
        ),
        Text(
          text2,
          style: const TextStyle(
            fontSize: AppSize.appSize16,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontRegular,
            color: AppColor.secondaryColor,
          ),
        ),
      ],
    );
  }

  _customHighlights(String image, String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSize.appSize16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSize.appSize6),
              child: Image.asset(
                image,
                width: AppSize.appSize52,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: AppSize.appSize12,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
