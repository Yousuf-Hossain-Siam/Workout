import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/progress/controllers/progress_controller.dart';
import 'package:luna_3/features/progress/widgets/nutrition_stats_grid.dart';
import 'package:luna_3/features/progress/widgets/stats_cards_row.dart';
import 'package:luna_3/features/progress/widgets/weekly_progress_section.dart';
import 'package:luna_3/features/home/widgets/custom_circular_progress.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProgressController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomAppBar(title: 'Progress', showNotification: true),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Progress Circle
                      Center(
                        child: Obx(
                          () => CustomCircularProgress(
                            percentage: controller.carbPercentage.value,
                            animation: controller.progressAnimation,
                            size: 170,
                            textSize: 10,
                            percentageSize: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Nutrition Stats Grid
                      NutritionStatsGrid(controller: controller),
                      const SizedBox(height: 30),

                      // Stats Cards
                      StatsCardsRow(controller: controller),
                      const SizedBox(height: 30),

                      // Weekly Progress Section
                      SizedBox(
                        height: 260,
                        child: WeeklyProgressSection(controller: controller),
                      ),
                      const SizedBox(height: 20),
                    ],
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
