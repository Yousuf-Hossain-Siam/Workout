import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/food_calories_controller.dart';

class TabButton extends StatelessWidget {
  final String title;
  final FoodCaloriesController controller;

  const TabButton({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedTab.value == title;
      return GestureDetector(
        onTap: () => controller.changeTab(title),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary : AppColors.appbar,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            title,
            style: getTextStyleWorkSans(
              color: isSelected ? AppColors.textPrimary : AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    });
  }
}