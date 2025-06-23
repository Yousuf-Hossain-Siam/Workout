import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/image_path.dart';
import 'package:luna_3/features/barbell_llm/view/barbell_llm_screen.dart';
import 'package:luna_3/features/food_logging/view/food_logging_screen.dart';
import 'package:luna_3/features/home/controllers/habit_state_controller.dart';
import 'package:luna_3/features/home/controllers/home_controller.dart';
import 'package:luna_3/features/home/view/choose_habits_screen.dart';
import 'package:luna_3/features/home/widgets/custom_circular_progress.dart';
import 'package:luna_3/features/home/widgets/habit_card.dart';
import 'package:luna_3/features/home/widgets/home_header.dart';
import 'package:luna_3/features/home/widgets/menu_item.dart';
import 'package:luna_3/features/home/widgets/nutrition_stats.dart';
import 'package:luna_3/features/notification/screen/notification_screen.dart';
import 'package:luna_3/features/recipes/view/recipes_screen.dart';
import 'package:luna_3/features/workout%20home/controller/all_workout_controller.dart';
import 'package:luna_3/features/workout%20home/view/all_workout_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());
  final HabitStateController habitController = Get.put(HabitStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              HomeHeader(
                image: ImagePath.femaleprofile,
                notificationTap: () {
                  Get.to(() => NotificationScreen());
                },
              ),
              const SizedBox(height: 36),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Obx(
                          () => CustomCircularProgress(
                            percentage: controller.carbPercentage.value,
                            animation: controller.progressAnimation,
                            size: 170,
                            textSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Nutrition Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(
                            () => NutritionStats(
                              value: '${controller.calories}',
                              label: 'CALORIES',
                            ),
                          ),
                          Obx(
                            () => NutritionStats(
                              value: '${controller.fats}g',
                              label: 'FATS',
                            ),
                          ),
                          Obx(
                            () => NutritionStats(
                              value: '${controller.proteins}g',
                              label: 'PROTEINS',
                            ),
                          ),
                          Obx(
                            () => NutritionStats(
                              value: '${controller.carbs}g',
                              label: 'CARBS',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Habits Card
                      Obx(
                        () => HabitCard(
                          title: habitController.getHabitCardTitle(),
                          subtitle: habitController.getHabitCardSubtitle(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChooseHabitsScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Menu Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1,
                        children: [
                          MenuItem(
                            icon: ImagePath.workoutimage,
                            title: 'Workouts',
                            subtitle: 'Sweating is self-care',
                            onTap: () async {
                              await Get.put(
                                AllWorkoutController(),
                              ).getAllWorkout();

                              Get.to(() => AllWorkoutScreen());
                            },
                          ),
                          MenuItem(
                            icon: ImagePath.foodeImage,
                            title: 'Food Logging',
                            subtitle: 'Select a meal',
                            onTap: () async {
                              Get.to(() => FoodLoggingScreen());
                            },
                          ),
                          MenuItem(
                            icon: ImagePath.recipeimage,
                            title: 'Recipes',
                            subtitle: 'Cook, eat, log, repeat',
                            onTap: () {
                              Get.to(() => const RecipesScreen());
                            },
                          ),
                          MenuItem(
                            icon: ImagePath.messageimage,
                            title: 'Barbell LLM',
                            subtitle: 'Ask Barbell',
                            onTap: () {
                              Get.to(() => const BarbellLLMScreen());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Progress Circle
            ],
          ),
        ),
      ),
    );
  }
}
