import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/food_favorites_controller.dart';
import 'package:luna_3/features/food_logging/models/food_calories_model.dart';
import 'package:luna_3/features/food_logging/widgets/food_info_row.dart';
import 'package:luna_3/features/food_logging/widgets/ingredients_list.dart';
import 'package:luna_3/features/food_logging/widgets/instructions_section.dart';
import 'package:luna_3/features/food_logging/widgets/track_button.dart';

class FoodDetailsScreen extends StatelessWidget {
  final FoodCaloriesModel foodItem;
  static const routeName = '/food-details';
  const FoodDetailsScreen({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.find<FoodFavoritesController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      body: Stack(
        children: [
          // Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.network(foodItem.img ?? '', fit: BoxFit.cover),
          ),

          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.appbar,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Favorite Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              foodItem.name ?? '',
                              style: getTextStyleWorkSans(
                                color: AppColors.textWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Obx(() {
                              final isFavorite = favoritesController.isFavorite(
                                foodItem,
                              );
                              return IconButton(
                                onPressed:
                                    () => favoritesController.toggleFavorite(
                                      foodItem,
                                    ),
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColors.secondary,
                                  size: 24,
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Info Row
                        FoodInfoRow(foodItem: foodItem),
                        const SizedBox(height: 24),

                        // Ingredients
                        IngredientsList(
                          ingredients: foodItem.ingredients ?? [],
                        ),
                        const SizedBox(height: 24),

                        // Instructions
                        InstructionsSection(
                          controller: TextEditingController(
                            text:
                                'Preheat the oven to 400°F (200°C). Place the chicken skin side up in an oven-proof baking dish. Add the garlic, ...',
                          ),
                          onChanged: (value) {
                            // TODO: Implement tracking
                          },
                        ),
                        const SizedBox(height: 24),

                        // Track Button
                        TrackButton(
                          text: 'Track',
                          onTap: () {
                            // TODO: Implement tracking
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
