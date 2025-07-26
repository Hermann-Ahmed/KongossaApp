// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/controller/home/home_controller.dart';
import 'package:kongossa/controller/status_controller.dart';
import 'package:kongossa/controller/auth_controller.dart';
import 'package:kongossa/controller/profile/settings_options/language_controller.dart';
import 'package:kongossa/model/social_media_post_model.dart';
import 'package:kongossa/model/status.dart';
import 'package:kongossa/model/user_model.dart';
import 'package:kongossa/routes/app_routes.dart';
import 'package:kongossa/views/home/options/reel/create_status_view.dart';
import 'package:kongossa/views/home/post/widgets/post_feed_section.dart';
import 'package:kongossa/views/widget/home/comments_bottom_sheet.dart';
import 'package:kongossa/views/widget/home/likes_bottom_sheet.dart';
import 'package:kongossa/views/widget/home/repost_bottom_sheet.dart';
import '../../config/app_font.dart';
import '../../config/app_size.dart';
import '../../config/app_string.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  StatusController statusController = Get.put(StatusController());
  LanguageController languageController = Get.put(LanguageController());

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _appBar(),
        body: _body(context),
      ),
    );
  }

  //Home content
  _appBar() {
    return AppBar(
      backgroundColor: AppColor.backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: false,
      scrolledUnderElevation: AppSize.appSize0,
      title: const Padding(
        padding:
            EdgeInsets.only(top: AppSize.appSize12, left: AppSize.appSize6),
        child: Text(
          AppString.primeSocialMedia,
          style: TextStyle(
            fontSize: AppSize.appSize20,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.appFontSevillanaRegular,
            color: AppColor.secondaryColor,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            top: AppSize.appSize12,
            right: AppSize.appSize18,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize13
                    : AppSize.appSize0,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppSize.appSize6
                      : AppSize.appSize0,
                  right: languageController.selectedLanguageIndex.value ==
                          AppSize.size2
                      ? AppSize.appSize0
                      : AppSize.appSize6,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.searchView);
                  },
                  child: Image.asset(
                    AppIcon.search,
                    width: AppSize.appSize32,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.messagesView);
                },
                child: Image.asset(
                  AppIcon.message,
                  width: AppSize.appSize32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: AppSize.appSize28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //story list begin
          // Doit contenir la liste des gens qui ont mis des stories
          SizedBox(
            height: AppSize.appSize100,
            child: Obx(() {
              final currentUserId = statusController.currentUserId;

              if (currentUserId == null) {
                return const Center(child: Text("Loading user data..."));
              }

              // Use the pre-computed reactive list of user IDs
              // This list already contains only users with VALID public statuses (except potentially current user if they have no public ones)
              final userIdsWithPublicStatus =
                  statusController.publicStatusUserIds;

              // Build the final list of user IDs to display.
              // We always want to show "Your story" first if the current user exists.
              final List<String> displayUserIds = [];
              displayUserIds
                  .add(currentUserId); // Always add current user first

              // Add other users' IDs, ensuring we don't duplicate if current user also has public status
              for (var userId in userIdsWithPublicStatus) {
                if (userId != currentUserId) {
                  displayUserIds.add(userId);
                }
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: displayUserIds.length,
                itemBuilder: (context, index) {
                  final userId = displayUserIds[index];

                  // --- Render "Your Story" section first ---
                  if (userId == currentUserId) {
                    return Obx(() {
                      // currentUserStatuses is already filtered by isStatusValid in your current code, which is correct.
                      final currentUserStatuses = statusController.userStatus
                          .where((status) => statusController
                              .isStatusValid(status)) // Correctly filtered!
                          .toList();
                      final hasStatus = currentUserStatuses.isNotEmpty;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSize.appSize10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (hasStatus) {
                                  Get.toNamed(AppRoutes.storyFullView,
                                      arguments: {
                                        'statuses':
                                            currentUserStatuses, // This is correctly filtered
                                        'userId': currentUserId,
                                      });
                                } else {
                                  Get.to(() => const StatusCreationView());
                                }
                              },
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: AppSize.appSize70,
                                    height: AppSize.appSize70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: hasStatus
                                          ? Border.all(
                                              color: Colors.blue, width: 3)
                                          : null,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Obx(() {
                                        final currentUser =
                                            authController.user.value;
                                        return Image.network(
                                          hasStatus &&
                                                  currentUserStatuses
                                                          .first.type ==
                                                      'image'
                                              ? currentUserStatuses
                                                  .first.contentUrl
                                              : currentUser?.profileImageUrl ??
                                                  'https://i.pravatar.cc/300',
                                          width: AppSize.appSize70,
                                          height: AppSize.appSize70,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              width: AppSize.appSize70,
                                              height: AppSize.appSize70,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.person,
                                                  size: 30),
                                            );
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                  if (!hasStatus)
                                    Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                        child: const Icon(Icons.add,
                                            size: 18, color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Votre story",
                              style: TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }

                  // --- Render other users' stories ---
                  // These statuses are already grouped and filtered by isStatusValid in the controller.
                  final userStatuses =
                      statusController.groupedPublicStatusByUser[userId];

                  // Crucially, ensure there are actual statuses to display for this user
                  if (userStatuses == null || userStatuses.isEmpty) {
                    return const SizedBox
                        .shrink(); // Hide if no valid public statuses
                  }

                  final firstStatus = userStatuses
                      .first; // This first status is guaranteed to be valid now

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.appSize10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.storyFullView,
                              arguments: {
                                'statuses':
                                    statusController.groupedPublicStatusByUser[userId], // This list is already filtered by isStatusValid
                                'userId': userId,
                              },
                            );
                          },
                          child: Container(
                            width: AppSize.appSize70,
                            height: AppSize.appSize70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue,
                                width: 3,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(
                                firstStatus.type == 'image'
                                    ? firstStatus.contentUrl
                                    : 'https://i.pravatar.cc/300?u=$userId',
                                width: AppSize.appSize70,
                                height: AppSize.appSize70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: AppSize.appSize70,
                                    height: AppSize.appSize70,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.person, size: 30),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        FutureBuilder<UserModel?>(
                          future: statusController.getUserInfo(userId),
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data?.username ?? 'Utilisateur',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color: AppColor.secondaryColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          PostsFeedSection(),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: AppSize.appSize20,
          //     right: AppSize.appSize20,
          //     top: AppSize.appSize32,
          //   ),
          //   child: Column(
          //     children: List.generate(posts.length, (index) {
          //       final socialPost = posts[index];
          //       return Padding(
          //         padding: const EdgeInsets.only(bottom: AppSize.appSize40),
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Row(
          //                   children: [
          //                     Padding(
          //                       padding: EdgeInsets.only(
          //                         right: languageController
          //                                     .selectedLanguageIndex.value ==
          //                                 AppSize.size2
          //                             ? AppSize.appSize0
          //                             : AppSize.appSize10,
          //                         left: languageController
          //                                     .selectedLanguageIndex.value ==
          //                                 AppSize.size2
          //                             ? AppSize.appSize10
          //                             : AppSize.appSize0,
          //                       ),
          //                       child: Image.asset(
          //                         socialPost.profileImage,
          //                         width: AppSize.appSize36,
          //                       ),
          //                     ),
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           socialPost.username,
          //                           style: const TextStyle(
          //                             fontSize: AppSize.appSize14,
          //                             fontWeight: FontWeight.w600,
          //                             fontFamily: AppFont.appFontSemiBold,
          //                             color: AppColor.secondaryColor,
          //                           ),
          //                         ),
          //                         Text(
          //                           socialPost.location,
          //                           style: const TextStyle(
          //                             fontSize: AppSize.appSize12,
          //                             fontWeight: FontWeight.w400,
          //                             fontFamily: AppFont.appFontRegular,
          //                             color: AppColor.text2Color,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //                 Row(
          //                   children: [
          //                     Padding(
          //                       padding: EdgeInsets.only(
          //                         right: AppSize.appSize8,
          //                         left: languageController
          //                                     .selectedLanguageIndex.value ==
          //                                 AppSize.size2
          //                             ? AppSize.appSize8
          //                             : AppSize.appSize0,
          //                       ),
          //                       child: Text(
          //                         socialPost.timeAgo,
          //                         style: const TextStyle(
          //                           fontSize: AppSize.appSize14,
          //                           fontWeight: FontWeight.w400,
          //                           fontFamily: AppFont.appFontRegular,
          //                           color: AppColor.text1Color,
          //                         ),
          //                       ),
          //                     ),
          //                     Image.asset(
          //                       AppIcon.more,
          //                       width: AppSize.appSize20,
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(top: AppSize.appSize12),
          //               child: Stack(
          //                 alignment: Alignment.bottomLeft,
          //                 children: [
          //                   Image.asset(
          //                     socialPost.postImage,
          //                     fit: BoxFit.cover,
          //                   ),
          //                   if (socialPost.showTagUserIcon)
          //                     Padding(
          //                       padding: const EdgeInsets.only(
          //                         left: AppSize.appSize10,
          //                         bottom: AppSize.appSize10,
          //                       ),
          //                       child: Image.asset(
          //                         AppIcon.tagUser,
          //                         width: AppSize.appSize24,
          //                       ),
          //                     ),
          //                   if (socialPost.showVolumeIcon)
          //                     Padding(
          //                       padding: const EdgeInsets.only(
          //                         right: AppSize.appSize10,
          //                         bottom: AppSize.appSize10,
          //                       ),
          //                       child: Align(
          //                         alignment: Alignment.bottomRight,
          //                         child: Image.asset(
          //                           AppIcon.volume,
          //                           width: AppSize.appSize24,
          //                         ),
          //                       ),
          //                     ),
          //                 ],
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(
          //                   top: AppSize.appSize14, bottom: AppSize.appSize14),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   _photoOptionWidget(
          //                     AppIcon.comment,
          //                     AppSize.appSize22,
          //                     AppString.comment10k,
          //                     onTap: () {
          //                       commentsBottomSheet(context);
          //                     },
          //                     onTapText: () {
          //                       commentsBottomSheet(context);
          //                     },
          //                   ),
          //                   _photoOptionWidget(
          //                     AppIcon.repost,
          //                     AppSize.appSize25,
          //                     AppString.repost15k,
          //                     onTap: () {
          //                       repostBottomSheet(context);
          //                     },
          //                     onTapText: () {
          //                       repostBottomSheet(context);
          //                     },
          //                   ),
          //                   Obx(() {
          //                     bool isLiked = homeController.isLiked.value;
          //                     return _photoOptionWidget(
          //                       isLiked ? AppIcon.like : AppIcon.emptyLike,
          //                       AppSize.appSize26,
          //                       AppString.likes55k,
          //                       onTap: () {
          //                         homeController.toggleLike();
          //                       },
          //                       onTapText: () {
          //                         likesBottomSheet(context);
          //                       },
          //                     );
          //                   }),
          //                   _photoOptionWidget(AppIcon.share, AppSize.appSize22,
          //                       AppString.share5k),
          //                   _photoOptionWidget(AppIcon.save, AppSize.appSize22,
          //                       AppString.save2k),
          //                 ],
          //               ),
          //             ),
          //             _customDivider(),
          //             Padding(
          //               padding: const EdgeInsets.only(top: AppSize.appSize14),
          //               child: RichText(
          //                 text: TextSpan(
          //                   text: socialPost.profileID,
          //                   style: const TextStyle(
          //                     fontSize: AppSize.appSize14,
          //                     fontWeight: FontWeight.w700,
          //                     fontFamily: AppFont.appFontBold,
          //                     color: AppColor.secondaryColor,
          //                   ),
          //                   children: [
          //                     TextSpan(
          //                       text: socialPost.postDescription,
          //                       style: const TextStyle(
          //                         fontSize: AppSize.appSize14,
          //                         fontWeight: FontWeight.w400,
          //                         fontFamily: AppFont.appFontRegular,
          //                         color: AppColor.secondaryColor,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     }),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSize.appSize20,
              right: AppSize.appSize20,
            ),
            child: Column(
              children: [
                _socialPostMessageWidget(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.appSize12, bottom: AppSize.appSize14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _photoOptionWidget(AppIcon.comment, AppSize.appSize22,
                          AppString.comment10k),
                      _photoOptionWidget(AppIcon.repost, AppSize.appSize25,
                          AppString.repost15k),
                      Obx(() {
                        bool isLiked = homeController.isLiked1.value;
                        return _photoOptionWidget(
                          isLiked ? AppIcon.like : AppIcon.emptyLike,
                          AppSize.appSize26,
                          AppString.likes55k,
                          onTap: () {
                            homeController.toggleLike1();
                          },
                        );
                      }),
                      _photoOptionWidget(
                          AppIcon.share, AppSize.appSize22, AppString.share5k),
                      _photoOptionWidget(
                          AppIcon.save, AppSize.appSize22, AppString.save2k),
                    ],
                  ),
                ),
                _customDivider(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize48,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            AppImage.post3,
                          ),
                          Container(
                            height: AppSize.appSize100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSize.appSize6),
                                topRight: Radius.circular(AppSize.appSize6),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black
                                      .withOpacity(AppSize.appSizePoint8),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: AppSize.appSize12,
                              right: AppSize.appSize12,
                              top: AppSize.appSize12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize0
                                            : AppSize.appSize10,
                                        left: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize10
                                            : AppSize.appSize0,
                                      ),
                                      child: Image.asset(
                                        AppImage.profile3,
                                        width: AppSize.appSize36,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          AppString.rajeshP,
                                          style: TextStyle(
                                            fontSize: AppSize.appSize14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: AppFont.appFontSemiBold,
                                            color: AppColor.secondaryColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: languageController
                                                            .selectedLanguageIndex
                                                            .value ==
                                                        AppSize.size2
                                                    ? AppSize.appSize0
                                                    : AppSize.appSize6,
                                              ),
                                              child: Image.asset(
                                                AppIcon.arrowRightUp,
                                                width: AppSize.appSize14,
                                              ),
                                            ),
                                            const Text(
                                              AppString.martinGarrix,
                                              style: TextStyle(
                                                fontSize: AppSize.appSize12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    AppFont.appFontRegular,
                                                color: AppColor.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: AppSize.appSize8,
                                        left: languageController
                                                    .selectedLanguageIndex
                                                    .value ==
                                                AppSize.size2
                                            ? AppSize.appSize8
                                            : AppSize.appSize0,
                                      ),
                                      child: const Text(
                                        AppString.min2,
                                        style: TextStyle(
                                          fontSize: AppSize.appSize14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppFont.appFontRegular,
                                          color: AppColor.text1Color,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      AppIcon.more,
                                      width: AppSize.appSize20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: AppSize.appSize14,
                                bottom: AppSize.appSize14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _photoOptionWidget(AppIcon.comment,
                                    AppSize.appSize22, AppString.comment10k),
                                _photoOptionWidget(AppIcon.repost,
                                    AppSize.appSize25, AppString.repost15k),
                                Obx(() {
                                  bool isLiked = homeController.isLiked2.value;
                                  return _photoOptionWidget(
                                    isLiked ? AppIcon.like : AppIcon.emptyLike,
                                    AppSize.appSize26,
                                    AppString.likes55k,
                                    onTap: () {
                                      homeController.toggleLike2();
                                    },
                                  );
                                }),
                                _photoOptionWidget(AppIcon.share,
                                    AppSize.appSize22, AppString.share5k),
                                _photoOptionWidget(AppIcon.save,
                                    AppSize.appSize22, AppString.save2k),
                              ],
                            ),
                          ),
                          _customDivider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: AppSize.appSize14,
                                bottom: AppSize.appSize40),
                            child: RichText(
                              text: const TextSpan(
                                text: AppString.rojModelID,
                                style: TextStyle(
                                  fontSize: AppSize.appSize14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppFont.appFontBold,
                                  color: AppColor.secondaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${AppString.loremString}\n",
                                    style: TextStyle(
                                      fontSize: AppSize.appSize14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppFont.appFontRegular,
                                      color: AppColor.secondaryColor,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: AppSize.appSize22),
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppString.post3Tags,
                                    style: TextStyle(
                                      fontSize: AppSize.appSize14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.appFontSemiBold,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _socialPostMessageWidget(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppSize.appSize12, bottom: AppSize.appSize14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _photoOptionWidget(AppIcon.comment, AppSize.appSize22,
                          AppString.comment10k),
                      _photoOptionWidget(AppIcon.repost, AppSize.appSize25,
                          AppString.repost15k),
                      Obx(() {
                        bool isLiked = homeController.isLiked3.value;
                        return _photoOptionWidget(
                          isLiked ? AppIcon.like : AppIcon.emptyLike,
                          AppSize.appSize26,
                          AppString.likes55k,
                          onTap: () {
                            homeController.toggleLike3();
                          },
                        );
                      }),
                      _photoOptionWidget(
                          AppIcon.share, AppSize.appSize22, AppString.share5k),
                      _photoOptionWidget(
                          AppIcon.save, AppSize.appSize22, AppString.save2k),
                    ],
                  ),
                ),
                _customDivider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSize.appSize40,
              bottom: AppSize.appSize40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSize.appSize16,
                    left: AppSize.appSize20,
                    right: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize20
                        : AppSize.appSize0,
                  ),
                  child: const Text(
                    AppString.trendingReels,
                    style: TextStyle(
                      fontSize: AppSize.appSize16,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFont.appFontSemiBold,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.appSize170,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize0
                          : AppSize.appSize20,
                    ),
                    itemCount: homeController.reelsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: AppSize.appSize120,
                          margin: EdgeInsets.only(
                            left: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize0
                                : AppSize.appSize20,
                            right: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize20
                                : AppSize.appSize0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppSize.appSize12),
                            image: DecorationImage(
                              image:
                                  AssetImage(homeController.reelsList[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          _repostMediaWidget(AppImage.post4),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSize.appSize12,
              left: AppSize.appSize20,
              right: AppSize.appSize20,
              bottom: AppSize.appSize30,
            ),
            child: RichText(
              text: const TextSpan(
                text: AppString.davidMorelID,
                style: TextStyle(
                  fontSize: AppSize.appSize14,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFont.appFontBold,
                  color: AppColor.secondaryColor,
                ),
                children: [
                  TextSpan(
                    text: AppString.loremString,
                    style: TextStyle(
                      fontSize: AppSize.appSize14,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.appFontRegular,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSize.appSize20),
            child: _repostMediaWidget(AppImage.post5),
          ),
        ],
      ),
    );
  }

  _customDivider() {
    return const Divider(
      color: AppColor.lineColor,
      height: AppSize.appSize0,
    );
  }

  _photoOptionWidget(String icon, double width, String text,
      {void Function()? onTap, void Function()? onTapText}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize0
                    : AppSize.appSize6,
            left:
                languageController.selectedLanguageIndex.value == AppSize.size2
                    ? AppSize.appSize6
                    : AppSize.appSize0,
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(
              icon,
              width: width,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTapText,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: AppSize.appSize14,
              fontWeight: FontWeight.w600,
              fontFamily: AppFont.appFontSemiBold,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  _socialPostMessageWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize0
                        : AppSize.appSize10,
                    left: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize10
                        : AppSize.appSize0,
                  ),
                  child: Image.asset(
                    AppImage.profile3,
                    width: AppSize.appSize36,
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.rajeshP,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFont.appFontSemiBold,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Text(
                      AppString.india,
                      style: TextStyle(
                        fontSize: AppSize.appSize12,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text2Color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: AppSize.appSize8,
                    left: languageController.selectedLanguageIndex.value ==
                            AppSize.size2
                        ? AppSize.appSize8
                        : AppSize.appSize0,
                  ),
                  child: const Text(
                    AppString.min2,
                    style: TextStyle(
                      fontSize: AppSize.appSize14,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.appFontRegular,
                      color: AppColor.text1Color,
                    ),
                  ),
                ),
                Image.asset(
                  AppIcon.more,
                  width: AppSize.appSize20,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSize.appSize12),
          child: RichText(
            text: const TextSpan(
              text: "${AppString.loremString}\n",
              style: TextStyle(
                fontSize: AppSize.appSize14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFont.appFontRegular,
                color: AppColor.secondaryColor,
              ),
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(top: AppSize.appSize28),
                  ),
                ),
                TextSpan(
                  text: "${AppString.postString}\n",
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.appFontRegular,
                    color: AppColor.secondaryColor,
                  ),
                ),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(top: AppSize.appSize28),
                  ),
                ),
                TextSpan(
                  text: AppString.postTags,
                  style: TextStyle(
                    fontSize: AppSize.appSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFont.appFontSemiBold,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _repostMediaWidget(String image) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSize.appSize10,
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize0
                          : AppSize.appSize10,
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize10
                          : AppSize.appSize0,
                    ),
                    child: Image.asset(
                      AppImage.profile4,
                      width: AppSize.appSize36,
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.davidMorel,
                        style: TextStyle(
                          fontSize: AppSize.appSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFont.appFontSemiBold,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      Text(
                        AppString.india,
                        style: TextStyle(
                          fontSize: AppSize.appSize12,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFont.appFontRegular,
                          color: AppColor.text2Color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: AppSize.appSize8,
                      left: languageController.selectedLanguageIndex.value ==
                              AppSize.size2
                          ? AppSize.appSize8
                          : AppSize.appSize0,
                    ),
                    child: const Text(
                      AppString.min33,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text1Color,
                      ),
                    ),
                  ),
                  Image.asset(
                    AppIcon.more,
                    width: AppSize.appSize20,
                  ),
                ],
              ),
            ],
          ),
          Container(
            // height: AppSize.appSize480,
            margin: const EdgeInsets.only(top: AppSize.appSize12),
            padding: const EdgeInsets.all(AppSize.appSize12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.appSize12),
              border: Border.all(color: AppColor.lineColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize0
                                : AppSize.appSize10,
                            left: languageController
                                        .selectedLanguageIndex.value ==
                                    AppSize.size2
                                ? AppSize.appSize10
                                : AppSize.appSize0,
                          ),
                          child: Image.asset(
                            AppImage.profile1,
                            width: AppSize.appSize36,
                          ),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.davidMorel,
                              style: TextStyle(
                                fontSize: AppSize.appSize14,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFont.appFontSemiBold,
                                color: AppColor.secondaryColor,
                              ),
                            ),
                            Text(
                              AppString.india,
                              style: TextStyle(
                                fontSize: AppSize.appSize12,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFont.appFontRegular,
                                color: AppColor.text2Color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      AppString.days9,
                      style: TextStyle(
                        fontSize: AppSize.appSize14,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.appFontRegular,
                        color: AppColor.text1Color,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize10,
                  ),
                  child: Image.asset(
                    image,
                    height: kIsWeb ? AppSize.appSize350 : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.appSize12),
                  child: RichText(
                    text: const TextSpan(
                      text: AppString.davidMorelID,
                      style: TextStyle(
                        fontSize: AppSize.appSize12,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppFont.appFontBold,
                        color: AppColor.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: AppString.loremString,
                          style: TextStyle(
                            fontSize: AppSize.appSize12,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFont.appFontRegular,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: AppSize.appSize12, bottom: AppSize.appSize14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _photoOptionWidget(
                    AppIcon.comment, AppSize.appSize22, AppString.comment10k),
                _photoOptionWidget(
                    AppIcon.repost, AppSize.appSize25, AppString.repost15k),
                Obx(() {
                  bool isLiked = homeController.isLiked4.value;
                  return _photoOptionWidget(
                    isLiked ? AppIcon.like : AppIcon.emptyLike,
                    AppSize.appSize26,
                    AppString.likes55k,
                    onTap: () {
                      homeController.toggleLike4();
                    },
                  );
                }),
                _photoOptionWidget(
                    AppIcon.share, AppSize.appSize22, AppString.share5k),
                _photoOptionWidget(
                    AppIcon.save, AppSize.appSize22, AppString.save2k),
              ],
            ),
          ),
          _customDivider(),
        ],
      ),
    );
  }
}
