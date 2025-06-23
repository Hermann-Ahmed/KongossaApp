import 'package:get/get.dart';
import 'package:kongossa/views/bottom_bar/bottom_bar_view.dart';
import 'package:kongossa/views/createpostScreen.dart';
import 'package:kongossa/views/forgot_password/code_confirmation_view.dart';
import 'package:kongossa/views/forgot_password/reset_password_view.dart';
import 'package:kongossa/views/forgot_password/your_account_view.dart';
import 'package:kongossa/views/home/home_view.dart';
import 'package:kongossa/views/home/messages/call/call_ringing_view.dart';
import 'package:kongossa/views/home/messages/call/call_view.dart';
import 'package:kongossa/views/home/messages/call/duo_call_view.dart';
import 'package:kongossa/views/home/messages/call/multiple_call_view.dart';
import 'package:kongossa/views/home/messages/camera_view.dart';
import 'package:kongossa/views/home/messages/messages_chat_view.dart';
import 'package:kongossa/views/home/messages/messages_view.dart';
import 'package:kongossa/views/home/messages/video_call/group_video_call_view.dart';
import 'package:kongossa/views/home/messages/video_call/video_call_ringing_view.dart';
import 'package:kongossa/views/home/options/reel/reel_full_view.dart';
import 'package:kongossa/views/home/options/repost/repost_view.dart';
import 'package:kongossa/views/home/options/story/story_with_message_view.dart';
import 'package:kongossa/views/home/post/all_post_view.dart';
import 'package:kongossa/views/home/search/search_view.dart';
import 'package:kongossa/views/new_post/reel/create_reel_view.dart';
import 'package:kongossa/views/new_post/reel/reel_capture_view.dart';
import 'package:kongossa/views/new_post/reel/reel_edit_view.dart';
import 'package:kongossa/views/new_post/reel/reel_upload_image_edit_view.dart';
import 'package:kongossa/views/new_post/reel/reel_upload_view.dart';
import 'package:kongossa/views/profile/edit_profile_view.dart';
import 'package:kongossa/views/profile/options/options_view/about_view.dart';
import 'package:kongossa/views/profile/options/options_view/account_view.dart';
import 'package:kongossa/views/profile/options/options_view/block_view.dart';
import 'package:kongossa/views/profile/options/options_view/comment_view.dart';
import 'package:kongossa/views/profile/options/options_view/help_view.dart';
import 'package:kongossa/views/profile/options/options_view/hidden_words_view.dart';
import 'package:kongossa/views/profile/options/options_view/hide_story_view.dart';
import 'package:kongossa/views/profile/options/options_view/language_view.dart';
import 'package:kongossa/views/profile/options/options_view/like_view.dart';
import 'package:kongossa/views/profile/options/options_view/notifications_option_view.dart';
import 'package:kongossa/views/profile/options/options_view/repost_option_view.dart';
import 'package:kongossa/views/profile/options/qr_code_view.dart';
import 'package:kongossa/views/profile/options/settings_view.dart';
import 'package:kongossa/views/reels/reels_view.dart';
import 'package:kongossa/views/signup/sign_up_view.dart';
import 'package:kongossa/views/welcome/welcome_view.dart';
import 'package:kongossa/views/widget/home/reels_play_full_view.dart';
import '../views/home/messages/video_call/video_call_view.dart';
import '../views/home/options/story/story_view.dart';
import '../views/login/login_view.dart';
import '../views/splash/splash_view.dart';

class AppRoutes {
  static const String splashView = "/splash_view";
  static const String loginView = "/login_view";
  static const String signUpView = "/sign_up_view";
  static const String yourAccountView = "/your_account_view";
  static const String codeConfirmationView = "/code_confirmation_view";
  static const String resetPasswordView = "/reset_password_view";
  static const String welcomeView = "/welcome_view";
  static const String homeView = "/home_view";
  static const String storyFullView = "/story_full_view";
  static const String reelFullView = "/reel_full_view";
  static const String repostView = "/repost_view";
  static const String searchView = "/search_view";
  static const String allPostView = "/all_post_view";
  static const String reelsPlayFullView = "/reels_play_full_view";
  static const String storyWithMessageView = "/story_with_message_view";
  static const String messagesView = "/messages_view";
  static const String messagesChatView = "/messages_chat_view";
  static const String cameraView = "/camera_view";
  static const String callView = "/call_view";
  static const String callRingingView = "/call_ringing_view";
  static const String duoCallView = "/duo_call_view";
  static const String multipleCallView = "/multiple_call_view";
  static const String videoCallRingingView = "/video_call_ringing_view";
  static const String videoCallView = "/video_call_view";
  static const String groupVideoCallView = "/group_video_call_view";
  static const String bottomBarView = "/bottom_bar_view";
  static const String createReelView = "/create_reel_view";
  static const String createPostView = "/create_post_view";
  static const String reelCaptureView = "/reel_capture_view";
  static const String reelEditView = "/reel_edit_view";
  static const String reelUploadView = "/reel_upload_view";
  static const String reelUploadImageEditView = "/reel_upload_image_edit_view";
  static const String qrCodeView = "/qr_code_view";
  static const String settingsView = "/settings_view";
  static const String accountView = "/account_view";
  static const String notificationsOptionView = "/notifications_option_view";
  static const String blockView = "/block_view";
  static const String hideStoryView = "/hide_story_view";
  static const String likeView = "/like_view";
  static const String commentView = "/comment_view";
  static const String repostOptionView = "/repost_option_view";
  static const String hiddenWordsView = "/hidden_words_view";
  static const String languageView = "/language_view";
  static const String helpView = "/help_view";
  static const String aboutView = "/about_view";
  static const String editProfileView = "/edit_profile_view";
  static const String reelsView = "/reels_view";

  static List<GetPage> pages = [
    GetPage(name: splashView, page: () => SplashView()),
    GetPage(name: loginView, page: () => LoginView()),
    GetPage(name: signUpView, page: () => SignUpView()),
    GetPage(name: yourAccountView, page: () => YourAccountView()),
    GetPage(name: codeConfirmationView, page: () => CodeConfirmationView()),
    GetPage(name: resetPasswordView, page: () => ResetPasswordView()),
    GetPage(name: welcomeView, page: () => const WelcomeView()),
    GetPage(name: homeView, page: () => HomeView()),
    GetPage(name: storyFullView, page: () => StoryFullView()),
    GetPage(name: reelFullView, page: () => ReelFullView()),
    GetPage(name: repostView, page: () => RepostView()),
    GetPage(name: searchView, page: () => SearchView()),
    GetPage(name: allPostView, page: () => AllPostView()),
    GetPage(name: reelsPlayFullView, page: () => ReelsPlayFullView()),
    GetPage(name: storyWithMessageView, page: () => StoryWithMessageView()),
    GetPage(name: messagesView, page: () => MessagesView()),
    GetPage(name: messagesChatView, page: () => MessagesChatView()),
    GetPage(name: cameraView, page: () => CameraView()),
    GetPage(name: callView, page: () => CallView()),
    GetPage(name: callRingingView, page: () => CallRingingView()),
    GetPage(name: duoCallView, page: () => DuoCallView()),
    GetPage(name: multipleCallView, page: () => MultipleCallView()),
    GetPage(name: videoCallRingingView, page: () => VideoCallRingingView()),
    GetPage(name: videoCallView, page: () => VideoCallView()),
    GetPage(name: groupVideoCallView, page: () => GroupVideoCallView()),
    GetPage(name: bottomBarView, page: () => BottomBarView()),
    GetPage(name: createReelView, page: () => CreateReelView()),
    GetPage(name: createPostView, page: () => AddPostScreen()),
    GetPage(name: reelCaptureView, page: () => ReelCaptureView()),
    GetPage(name: reelEditView, page: () => ReelEditView()),
    GetPage(name: reelUploadView, page: () => ReelUploadView()),
    GetPage(
        name: reelUploadImageEditView, page: () => ReelUploadImageEditView()),
    GetPage(name: qrCodeView, page: () => QRCodeView()),
    GetPage(name: settingsView, page: () => const SettingsView()),
    GetPage(name: accountView, page: () => AccountView()),
    GetPage(
        name: notificationsOptionView, page: () => NotificationsOptionsView()),
    GetPage(name: blockView, page: () => BlockView()),
    GetPage(name: hideStoryView, page: () => HideStoryView()),
    GetPage(name: likeView, page: () => LikeView()),
    GetPage(name: commentView, page: () => CommentView()),
    GetPage(name: repostOptionView, page: () => RepostOptionView()),
    GetPage(name: hiddenWordsView, page: () => HiddenWordsView()),
    GetPage(name: languageView, page: () => LanguageView()),
    GetPage(name: helpView, page: () => HelpView()),
    GetPage(name: aboutView, page: () => AboutView()),
    GetPage(name: editProfileView, page: () => EditProfileView()),
    GetPage(name: reelsView, page: () => ReelsView()),
  ];
}
