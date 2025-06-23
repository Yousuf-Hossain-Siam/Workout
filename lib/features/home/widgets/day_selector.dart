import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/home/controllers/weekly_habits_controller.dart';

class DaySelector extends StatelessWidget {
  final WeeklyHabitsController controller;

  const DaySelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.appbar.withValues(alpha: 0.9),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.appbar.withValues(alpha: 0.7),
              AppColors.appbar.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Days',
              style: getTextStyleInter(
                color: AppColors.textWhite,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: 7,
              itemBuilder:
                  (context, index) => _buildDayButton(context, index + 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayButton(BuildContext context, int day) {
    return Obx(() {
      final isSelected = controller.selectedDays.contains(day);
      return GestureDetector(
        onTap: () => controller.toggleDaySelection(day),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isSelected
                    ? AppColors.primary.withValues(alpha: 0.8)
                    : Colors.transparent,
            border: Border.all(
              color:
                  isSelected
                      ? AppColors.primary
                      : AppColors.textWhite.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: -2,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : [],
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: getTextStyleInter(
                color: isSelected ? Colors.white : AppColors.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
              child: Text(controller.getDayName(day)),
            ),
          ),
        ),
      );
    });
  }
}
