import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';
import 'package:luna_3/features/food_logging/controllers/food_calories_controller.dart';
import 'package:luna_3/features/workout%20home/view/add_exercise_screen.dart';
import 'package:luna_3/features/workout%20home/widgets/workout_entry_card.dart';

class WorkoutScreen extends StatelessWidget {
  final bool isBottomNav;
  WorkoutScreen({super.key, this.isBottomNav = true});
  final controller = Get.put(FoodCaloriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar:
          isBottomNav ? CustomBottomNavBar() : SizedBox.shrink(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: 'All Exercise',
                showBackButton: true, // Show back button
                showNotification: true, // Show notification icon
                onBackPressed: () {
                  Get.back(); // Navigate back when back button is pressed
                },
              ),
              Column(
                children: [
                  Center(
                    child: WorkoutEntryCard(
                      title: "Get Started",
                      description: "Add Exercise to start you workout",
                      iconPath: IconPath.dumbel,
                      buttonText: "Add Exercise",
                      onTap: () {
                        Get.to(() => const AddExerciseScreen());
                        // Get.to(AllWorkoutScreen());
                      },
                    ),
                  ).paddingOnly(top: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
