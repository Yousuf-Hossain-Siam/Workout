import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/logged_food_controller.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';

class MealSection extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MealSection({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final loggedFoodController = Get.find<LoggedFoodController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.appbar,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: getTextStyleWorkSans(
                        color: AppColors.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      final calories = loggedFoodController
                          .getTotalCaloriesForMeal(title);
                      if (calories > 0) {
                        return Text(
                          '$calories Cal eaten',
                          style: getTextStyleWorkSans(
                            color: AppColors.textWhite,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                      return Text(
                        '0 Cal eaten',
                        style: getTextStyleWorkSans(
                          color: AppColors.textWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    loggedFoodController.setCurrentMealType(title);
                    onTap();
                  },
                  child: SvgPicture.asset(
                    SvgPath.addSvg,
                    width: 34,
                    height: 34,
                  ),
                ),
              ],
            ),
          ),

          // Food Items List
          Obx(() {
            final foodItems =
                loggedFoodController.loggedFoodByMeal[title] ?? [];
            if (foodItems.isEmpty) return const SizedBox.shrink();

            return Column(
              children: [
                const Divider(
                  color: AppColors.habitSub,
                  height: 1,
                  thickness: 0.8,
                  indent: 16,
                  endIndent: 16,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: foodItems.length,
                  itemBuilder: (context, index) {
                    final item = foodItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                item.name,
                                style: getTextStyleWorkSans(
                                  color: AppColors.textWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap:
                                    () => loggedFoodController.removeFoodItem(
                                      title,
                                      index,
                                    ),
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.textWhite,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${item.calories} Cal',
                            style: getTextStyleWorkSans(
                              color: AppColors.textWhite,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
