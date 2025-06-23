import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/food_calories_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_logging_controller.dart';
import 'package:luna_3/features/food_logging/controllers/logged_food_controller.dart';
import 'package:luna_3/features/food_logging/enums/food_loggin_enums.dart';
import 'package:luna_3/features/food_logging/view/food_list_screen.dart';
import 'package:luna_3/features/food_logging/widgets/meal_section.dart';
import 'package:luna_3/features/food_logging/widgets/nutrition_card.dart';

class FoodLoggingScreen extends StatelessWidget {
  static const String routeName = '/food-logging';

  const FoodLoggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodLoggingController());
    Get.put(LoggedFoodController());

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      appBar: AppBarWidget(title: 'Today', showNotification: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              // CustomAppBar(
              //   title: 'Today',
              //   showNotification: true,
              //   showBackButton: true,
              //   onNotificationPressed: () {},
              // ),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Nutrition Card
                      const NutritionCard(),
                      const SizedBox(height: 24),

                      // Meal Sections
                      MealSection(
                        title: FoodLogginEnums.breakfast.name.toUpperCase(),
                        onTap: () async {
                          controller.consumedAs.value =
                              FoodLogginEnums.breakfast;
                          Get.to(() => const FoodListScreen());

                          ///TODO: getAllFoods should not be called here. It should be called in the home screen once.
                          await Get.find<FoodCaloriesController>()
                              .getAllFoods();
                        },
                      ),
                      const SizedBox(height: 16),
                      MealSection(
                        title: FoodLogginEnums.lunch.name.toUpperCase(),
                        onTap: () async {
                          controller.consumedAs.value = FoodLogginEnums.lunch;
                          Get.to(() => const FoodListScreen());

                          ///TODO: getAllFoods should not be called here. It should be called in the home screen once.
                          await Get.find<FoodCaloriesController>()
                              .getAllFoods();
                        },
                      ),
                      const SizedBox(height: 16),
                      MealSection(
                        title: FoodLogginEnums.dinner.name.toUpperCase(),
                        onTap: () async {
                          controller.consumedAs.value = FoodLogginEnums.dinner;
                          Get.to(() => const FoodListScreen());

                          ///TODO: getAllFoods should not be called here. It should be called in the home screen once.
                          await Get.find<FoodCaloriesController>()
                              .getAllFoods();
                        },
                      ),
                      const SizedBox(height: 16),
                      MealSection(
                        title: FoodLogginEnums.snacks.name.toUpperCase(),
                        // title: 'Snacks',
                        onTap: () async {
                          controller.consumedAs.value = FoodLogginEnums.snacks;
                          Get.to(() => const FoodListScreen());
                          await Get.find<FoodCaloriesController>()
                              .getAllFoods();
                        },
                      ),

                      const SizedBox(height: 80),
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
