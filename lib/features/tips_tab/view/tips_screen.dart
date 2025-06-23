import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/utils/constants/sizer.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';
import 'package:luna_3/features/tips_tab/controllers/article_controller.dart';
import 'package:luna_3/features/tips_tab/controllers/video_controller.dart';
import 'package:luna_3/features/tips_tab/view/fitness_tips_articles_screen.dart';
import 'package:luna_3/features/tips_tab/view/fitness_tips_video_screen.dart';
import 'package:luna_3/features/tips_tab/view/upload_tips_screen.dart';
import 'package:luna_3/features/tips_tab/widgets/tips_home_card.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleController = Get.put(ArticleController());
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Fitness Tips & Blog',
        showNotification: true,
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.put(VideoController());
                    Get.to(() => const FitnessTipsVideoScreen());
                  },
                  child: TipsTabCard(
                    label: 'Video',
                    icon: SvgPath.playButtonSvg,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // articleController.getAllArticles();
                    Get.to(() => FitnessTipsScreen());
                  },
                  child: TipsTabCard(label: 'Articles', icon: SvgPath.article),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.put(VideoController());
                    Get.to(() => const FitnessTipsVideoScreen(isSaved: true));
                  },
                  child: TipsTabCard(
                    label: 'Save Video',
                    icon: SvgPath.saveTag,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // articleController.getAllArticles();
                    Get.to(() => FitnessTipsScreen(isSaved: true));
                  },
                  child: TipsTabCard(
                    label: 'Save Articles',
                    icon: SvgPath.saveTag,
                  ),
                ),
              ],
            ),

            Spacer(),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                fixedSize: Size(Sizer.wp(244), 56),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(color: Color(0xff373D02), width: 0.86),
              ),
              onPressed: () {
                Get.to(() => UploadTipsScreen());
              },
              label: Text(
                'Upload New Tip',
                style: getTextStyleWorkSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 2.22,
                ),
              ),
              icon: SvgPicture.asset(SvgPath.uploadIcon),
            ),
          ],
        ),
      ),
    );
  }
}
