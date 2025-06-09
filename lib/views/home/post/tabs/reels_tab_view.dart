// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_font.dart';
import 'package:kongossa/config/app_icon.dart';
import 'package:kongossa/controller/home/all_post_controller.dart';
import 'package:kongossa/routes/app_routes.dart';

import '../../../../config/app_size.dart';

class ReelsTabView extends StatelessWidget {
  ReelsTabView({Key? key}) : super(key: key);

  AllPostController allPostController = Get.put(AllPostController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.appSize20,
        right: AppSize.appSize20,
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppSize.size4,
          mainAxisExtent: kIsWeb ? AppSize.appSize250 : AppSize.appSize157,
          crossAxisSpacing: AppSize.appSize1,
          mainAxisSpacing: AppSize.appSize1,
        ),
        itemCount: allPostController.reelsList.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.reelsView);
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(allPostController.reelsList[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSize.appSize6,
                    left: AppSize.appSize6,
                  ),
                  child: Image.asset(
                    AppIcon.reelFill,
                    width: AppSize.appSize16,
                  ),
                ),
                Positioned(
                  bottom: AppSize.appSize1,
                  left: AppSize.appSize2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIcon.play,
                        width: AppSize.appSize14,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSize.appSize3),
                        child: Text(
                          allPostController.reelsViewList[index],
                          style: const TextStyle(
                            fontSize: AppSize.appSize12,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.appFontSemiBold,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
