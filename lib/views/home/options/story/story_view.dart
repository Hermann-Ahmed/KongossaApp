// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:story_view/story_view.dart';

class StoryFullView extends StatelessWidget {
  StoryFullView({super.key});

  StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: _buildHighlights(),
      ),
    );
  }

  //Story full view content
  Widget _buildHighlights() {
    final List<StoryItem> stories = [
      StoryItem.inlineImage(
        url: AppString.story1,
        controller: controller,
        roundedTop: false,
      ),
      StoryItem.inlineImage(
        url: AppString.story2,
        controller: controller,
        roundedTop: false,
      ),
      StoryItem.inlineImage(
        url: AppString.story3,
        controller: controller,
        roundedTop: false,
      ),
      StoryItem.inlineImage(
        url: AppString.story4,
        controller: controller,
        roundedTop: false,
      ),
      StoryItem.inlineImage(
        url: AppString.story5,
        controller: controller,
        roundedTop: false,
      ),
    ];

    return StoryView(
      storyItems: stories,
      repeat: true,
      inline: true,
      progressPosition: ProgressPosition.top,
      controller: controller,
      onComplete: () {
        Get.back();
      },
      onVerticalSwipeComplete: (v) {
        if (v == Direction.down) {
          Get.back();
        }
      },
    );
  }
}
