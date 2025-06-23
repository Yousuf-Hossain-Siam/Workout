import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/tips_tab/controllers/article_controller.dart';
import 'package:luna_3/features/tips_tab/models/article_model.dart';
import 'package:luna_3/features/tips_tab/widgets/article_card.dart';

class FitnessTipsScreen extends StatelessWidget {
  const FitnessTipsScreen({super.key, this.isSaved});
  final bool? isSaved;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Fitness Tips", showNotification: true),
      body: _FitnessTipsBody(isSaved: isSaved),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class _FitnessTipsBody extends StatelessWidget {
  const _FitnessTipsBody({this.isSaved});
  final bool? isSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        children: [
          if (isSaved != true) _buildSearchField(),
          if (isSaved != true) const SizedBox(height: 16),

          _buildArticlesList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    final ArticleController articleController = Get.find<ArticleController>();
    return TextField(
      controller: articleController.searchController,
      style: AppTextStyle.f14W400().copyWith(color: AppColors.textSub),
      decoration: InputDecoration(
        hintText: 'Search for tips and articles',
        suffixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFF1C2227),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) {
        articleController.searchArticles(value, isSaved: isSaved);
      },
    );
  }

  Widget _buildArticlesList() {
    return Expanded(
      child: GetBuilder<ArticleController>(
        builder: (controller) {
          if (controller.articles.isEmpty) {
            return const Center(child: Text('No articles found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 22.0),
            itemCount:
                isSaved == true
                    ? controller.savedArticles.length
                    : controller.articles.length,
            itemBuilder: (context, index) {
              final ArticleModel article =
                  isSaved == true
                      ? controller.savedArticles[index]
                      : controller.articles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ArticleCard(articleModel: article),
              );
            },
          );
        },
      ),
    );
  }
}
