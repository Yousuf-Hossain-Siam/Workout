import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/food_logging_controller.dart';
import 'package:luna_3/features/food_logging/widgets/nutrition_progress_bar.dart';
import 'package:luna_3/features/home/widgets/custom_circular_progress.dart';

class NutritionCard extends StatelessWidget {
  const NutritionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final foodController = Get.find<FoodLoggingController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.appbar,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - Nutrition information
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calories
                Obx(
                  () => _buildNutritionRow(
                    foodController.calories.value.toString(),
                    foodController.maxCalories.toString(),
                    'Calories',
                    foodController.caloriesProgress,
                  ),
                ),
                const SizedBox(height: 20),

                // Fats
                Obx(
                  () => _buildNutritionRow(
                    '${foodController.fats.value}g',
                    '${foodController.maxFats}g',
                    'Fats',
                    foodController.fatsProgress,
                  ),
                ),
                const SizedBox(height: 20),

                // Proteins
                Obx(
                  () => _buildNutritionRow(
                    '${foodController.proteins.value}g',
                    foodController.maxProteins.toString(),
                    'Proteins',
                    foodController.proteinsProgress,
                  ),
                ),
                const SizedBox(height: 20),

                // Carbs
                Obx(
                  () => _buildNutritionRow(
                    '${foodController.carbs.value}g',
                    '${foodController.maxCarbs}g',
                    'Carbs',
                    foodController.carbsProgress,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right side - Circular Progress
          Expanded(
            flex: 7,
            child: Obx(
              () => CustomCircularProgress(
                percentage: foodController.carbPercentage,
                animation: foodController.progressAnimation,
                size: 150,
                textSize: 10,
                percentageSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(
    String value,
    String maxValue,
    String label,
    double progress,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$value / $maxValue',
              style: getTextStyleWorkSans(
                color: AppColors.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: getTextStyleWorkSans(
                color: AppColors.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        NutritionProgressBar(value: progress, color: AppColors.secondary),
      ],
    );
  }
}
