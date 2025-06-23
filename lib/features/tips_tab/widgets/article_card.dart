import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/sizer.dart';
import 'package:luna_3/features/tips_tab/controllers/article_controller.dart';
import 'package:luna_3/features/tips_tab/models/article_model.dart';
import 'package:luna_3/features/tips_tab/widgets/filled_tonal_button.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.articleModel, this.onSave});

  final ArticleModel articleModel;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).cardColor,  // Use theme colors
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategory(),
                const SizedBox(height: 10),
                _buildTitle(),
                const SizedBox(height: 8),
                _buildDescription(),
                const SizedBox(height: 16),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: Image.network(
        articleModel.imageUrl ?? 'https://picsum.photos/187/300',
        height: 187,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error)),
      ),
    );
  }

  Widget _buildCategory() {
    return Text(
      articleModel.category,
      style: getTextStyleInter(
        color: AppColors.textTitle,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.50,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      articleModel.title,
      style: getTextStyleInter(
        color: AppColors.textTitle,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.50,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      articleModel.description ?? '',
      style: getTextStyleInter(color: AppColors.textDescription),
    );
  }

  Widget _buildFooter() {
    final artController = Get.find<ArticleController>();
    return Row(
      children: [
        FilledTonalButton(
          icon: Icons.favorite_rounded,
          text: articleModel.likes.toString(),
          isClicked: articleModel.isFavorite,
          onClick: () {
            artController.toggleFavorite(articleModel.id);
          },
        ),
        SizedBox(width: Sizer.wp(25)),
        FilledTonalButton(
          icon: Icons.bookmark_rounded,
          text: "Save",
          isClicked: articleModel.isSaved,
          onClick: () {
            artController.toggleSaved(articleModel.id);
          },
        ),
      ],
    );
  }
}
