import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/food_image_controller.dart';
import 'package:luna_3/features/food_logging/view/add_food_manually_screen.dart';
import 'package:luna_3/features/food_logging/view/food_details_screen.dart';
import 'package:luna_3/features/recipes/controllers/recipes_controller.dart';
import 'package:luna_3/features/recipes/widgets/recipe_card.dart';

class MyRecipesScreen extends StatelessWidget {
  const MyRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FoodImageController());
    final controller = Get.find<RecipesController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomAppBar(
                    title: 'My Recipes',
                    showBackButton: true,
                    showNotification: true,
                  ),
                ),
                const SizedBox(height: 20),
                // Recipe Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() {
                      final myRecipes =
                          controller.allRecipes
                              .where((recipe) => recipe.isMyRecipe)
                              .toList();

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.2,
                            ),
                        itemCount: myRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = myRecipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onTap:
                                () => Get.to(
                                  () => FoodDetailsScreen(
                                    foodItem: recipe.toFoodItem(),
                                  ),
                                ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
            // Created Button at bottom
            Positioned(
              bottom: 46,
              right: 20,
              child: Center(
                child: GestureDetector(
                  onTap: () => Get.to(() => const AddFoodManuallyScreen()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Created',
                      style: getTextStyleWorkSans(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
