import 'package:kongossa/config/app_image.dart';
import 'package:kongossa/config/app_string.dart';

class SocialMediaPostModel {
  final String username;
  final String location;
  final String timeAgo;
  final String profileImage;
  final String profileID;
  final String postImage;
  final String postDescription;
  final bool showTagUserIcon;
  final bool showVolumeIcon;

  SocialMediaPostModel({
    required this.username,
    required this.location,
    required this.timeAgo,
    required this.profileImage,
    required this.profileID,
    required this.postImage,
    required this.postDescription,
    this.showTagUserIcon = false,
    this.showVolumeIcon = false,
  });
}

List<SocialMediaPostModel> posts = [
  SocialMediaPostModel(
    username: AppString.davidMorel,
    location: AppString.india,
    timeAgo: AppString.min33,
    profileImage: AppImage.profile1,
    profileID: AppString.davidMorelID,
    postImage: AppImage.post1,
    postDescription: AppString.loremString,
    showTagUserIcon: true,
    showVolumeIcon: true,
  ),
  SocialMediaPostModel(
    username: AppString.rojModel,
    location: AppString.indonesia,
    timeAgo: AppString.min2,
    profileImage: AppImage.profile2,
    profileID: AppString.rojModelID,
    postImage: AppImage.post2,
    postDescription: AppString.loremString,
    showTagUserIcon: false,
    showVolumeIcon: true,
  ),
];
