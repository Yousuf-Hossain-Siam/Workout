import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/tips_tab/controllers/video_controller.dart';
import 'package:luna_3/features/tips_tab/models/article_model.dart';
import 'package:luna_3/features/tips_tab/widgets/video_card.dart';

class FitnessTipsVideoScreen extends StatelessWidget {
  const FitnessTipsVideoScreen({super.key, this.isSaved});
  final bool? isSaved;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
      init: VideoController(),
      builder:
          (controller) => Scaffold(
            appBar: AppBarWidget(
              title: "Fitness Videos",
              showNotification: true,
            ),
            body: _FitnessTipsVideoBody(isSaved: isSaved),
          ),
    );
  }
}

class _FitnessTipsVideoBody extends StatelessWidget {
  const _FitnessTipsVideoBody({this.isSaved});
  final bool? isSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        children: [
          if (isSaved != true) _buildSearchField(),
          if (isSaved != true) const SizedBox(height: 16),
          _buildVideosList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return GetBuilder<VideoController>(
      builder:
          (controller) => TextField(
            controller: controller.searchController,
            style: getTextStyleInter(color: AppColors.textSub),
            decoration: InputDecoration(
              hintText: 'Search for videos',
              suffixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              controller.searchVideos(value, isSaved: isSaved);
            },
          ),
    );
  }

  Widget _buildVideosList() {
    return Expanded(
      child: GetBuilder<VideoController>(
        builder: (controller) {
          if (controller.articles.isEmpty) {
            return const Center(child: Text('No videos found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 22.0),
            itemCount:
                isSaved == true
                    ? controller.savedArticles.length
                    : controller.articles.length,
            itemBuilder: (context, index) {
              final ArticleModel video =
                  isSaved == true
                      ? controller.savedArticles[index]
                      : controller.articles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: VideoCard(articleModel: video),
              );
            },
          );
        },
      ),
    );
  }
}
