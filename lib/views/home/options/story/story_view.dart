import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/model/status.dart';
import 'package:story_view/story_view.dart';


class StoryFullView extends StatelessWidget {
  StoryFullView({super.key});

  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _buildHighlights(),
      ),
    );
  }

  Widget _buildHighlights() {
    final arguments = Get.arguments;

    final List<Status> statuses = arguments['statuses'] ?? [];

    final List<StoryItem> stories = statuses.map<StoryItem>((status) {
      return StoryItem.inlineImage(
        url: status.contentUrl, // tu dois avoir ce champ dans ton modèle
        controller: controller,
        roundedTop: false,
      );
    }).toList();

    return StoryView(
      storyItems: stories,
      repeat: true,
      inline: true,
      progressPosition: ProgressPosition.top,
      controller: controller,
      onComplete: () {
        Get.back();
      },
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Get.back();
        }
      },
    );
  }
}
