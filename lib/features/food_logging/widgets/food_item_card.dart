import 'package:flutter/material.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/models/food_calories_model.dart';

class FoodItemCard extends StatelessWidget {
  final FoodCaloriesModel foodItem;
  final VoidCallback onAdd;

  const FoodItemCard({super.key, required this.foodItem, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.appbar,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              foodItem.img ?? '',
              width: 72,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          const SizedBox(width: 12),

          // Food Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  foodItem.name ?? '',
                  style: getTextStyleWorkSans(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${foodItem.nutritionPerServing?.calories} Cal',
                  style: getTextStyleWorkSans(
                    color: AppColors.textWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Add Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: GestureDetector(
                onTap: onAdd,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: .27),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Add',
                    style: getTextStyleWorkSans(
                      color: AppColors.textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
