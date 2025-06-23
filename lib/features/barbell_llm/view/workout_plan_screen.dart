import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';
import 'package:luna_3/features/barbell_llm/controllers/barbell_llm_controller.dart';
import 'package:luna_3/features/barbell_llm/widgets/workout_section.dart';
import 'package:luna_3/features/barbell_llm/widgets/workout_day_card.dart';
import 'package:luna_3/features/barbell_llm/widgets/feedback_section.dart';

class WorkoutPlanScreen extends StatelessWidget {
  const WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BarbellLLMController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomAppBar(
                title: 'Workout Plan',
                showNotification: true,
                showBackButton: true,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Goal Section
                      WorkoutSection(
                        icon: SvgPath.goalSvg,
                        title: 'Goal',
                        subTitle: 'Strength & Muscle',
                        content:
                            'Strength 4 days Focus on compound lifts and progressive overload.',
                      ),

                      const SizedBox(height: 16),
                      // Equipment Section
                      WorkoutSection(
                        icon: SvgPath.equipmentSvg,
                        title: 'Equipment',
                        subTitle: 'Dumbbells, Barbell, Bands',
                        content:
                            'Plan adapts to your available equipment for each session.',
                      ),

                      const SizedBox(height: 16),

                      // Weekly Schedule Section
                      Text(
                        'Weekly Schedule',
                        style: getTextStyleWorkSans(
                          color: AppColors.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.8,
                        children: [
                          WorkoutDayCard(
                            day: 'Monday',
                            exercises: [
                              'Full Body A',
                              'Squat, Bench, Row',
                              '4x8',
                              '60s rest',
                            ],
                          ),
                          WorkoutDayCard(
                            day: 'Wednesday',
                            exercises: [
                              'Full Body B',
                              'Deadlift, Press, Pull-up',
                              '4x6',
                              '90s rest',
                            ],
                          ),
                          WorkoutDayCard(
                            day: 'Friday',
                            exercises: [
                              'Full Body A',
                              'Squat, Bench, Row',
                              '4x8',
                              '60s rest',
                            ],
                          ),
                          WorkoutDayCard(
                            day: 'Saturday',
                            exercises: [
                              'Accessory',
                              'Arms, Core, Cardio',
                              '3x12',
                              '45s rest',
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FeedbackSection(
              controller: controller.feedbackController,
              onUpdate: () {
                // TODO: Implement update plan
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
