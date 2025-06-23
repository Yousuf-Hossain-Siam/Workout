import 'package:flutter/material.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/recipes/models/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final double width;
  final double height;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.width = double.infinity,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.appbar,
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Recipe Image
              Image.asset(recipe.imageUrl, fit: BoxFit.cover),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              // Recipe Name in Center
              Center(
                child: Text(
                  recipe.name,
                  style: getTextStyleWorkSans(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Calories in Bottom Right
              Positioned(
                right: 10,
                bottom: 10,
                child: Text(
                  '${recipe.calories} Cal',
                  style: getTextStyleWorkSans(
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
