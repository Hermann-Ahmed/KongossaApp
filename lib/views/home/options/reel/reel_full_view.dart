// ignore_for_file: unrelated_type_equality_checks, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:story_view/story_view.dart';

class ReelFullView extends StatelessWidget {
  ReelFullView({super.key});

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

  //Reel full view content
  Widget _buildHighlights() {
    final List<StoryItem> stories = [
      StoryItem.pageVideo(
        AppString.reelVideoLink2,
        controller: controller,
        duration: const Duration(seconds: AppSize.size29),
      ),
    ];

    return StoryView(
      storyItems: stories,
      repeat: false,
      inline: true,
      progressPosition: ProgressPosition.bottom,
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
