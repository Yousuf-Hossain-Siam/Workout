import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/common/widgets/search_input_decoration.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';
import 'package:luna_3/features/food_logging/controllers/food_calories_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_favorites_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_image_controller.dart';
import 'package:luna_3/features/food_logging/view/add_food_manually_screen.dart';
import 'package:luna_3/features/food_logging/view/barcode_scanner_screen.dart';
import 'package:luna_3/features/food_logging/view/food_details_screen.dart';
import 'package:luna_3/features/food_logging/widgets/food_entry_option_card.dart';
import 'package:luna_3/features/food_logging/widgets/food_item_card.dart';
import 'package:luna_3/features/food_logging/widgets/tab_button.dart';
import 'package:shimmer/shimmer.dart';

class FoodListScreen extends StatelessWidget {
  static const routeName = '/food-list-screen';
  const FoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodCaloriesController>();

    Get.put(FoodFavoritesController());
    Get.put(FoodImageController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(
        title: 'Foods',
        showNotification: true,
        actions: [
          Tooltip(
            message: 'Create new food item',
            child: IconButton(
              icon: const Icon(Icons.add, color: AppColors.textWhite),
              onPressed: () {
                Get.to(() => const AddFoodManuallyScreen(isCreate: false));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // -------------- Search Bar --------------
              TextField(
                onChanged: controller.updateSearchQuery,
                style: getTextStyleWorkSans(
                  color: AppColors.textWhite,
                  fontSize: 16,
                ),
                decoration: searchTextfeildDecoration(),
              ),

              // -------------- Tabs --------------
              const SizedBox(height: 20),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.appbar,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TabButton(title: 'All', controller: controller),
                          const SizedBox(width: 16),
                          TabButton(title: 'favorites', controller: controller),
                          const SizedBox(width: 16),
                          TabButton(title: 'Manual', controller: controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // -------------- Content based on selected tab --------------
              Expanded(
                child: Obx(() {
                  switch (controller.selectedTab.value) {
                    case 'Manual':
                      return _buildManualTabContent(controller);
                    case 'favorites':
                      return _buildFavoritesTabContent(controller);
                    default:
                      return _buildAllTabContent(controller);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManualTabContent(FoodCaloriesController controller) {
    final imageController = Get.find<FoodImageController>();

    return SingleChildScrollView(
      child: Column(
        children: [
          FoodEntryOptionCard(
            isManualEntry: true,
            title: 'Manual Entry',
            description:
                'Enter food details, calories, macros, and portion size.',
            iconPath: SvgPath.manualEntrySvg,
            buttonText: 'Add Manually',
            onTap: () {
              Get.to(() => const AddFoodManuallyScreen(isCreate: false));
            },
          ),
          FoodEntryOptionCard(
            title: 'Snap Photo',
            description:
                'Use your camera to log food. AI will estimate nutrition.',
            iconPath: SvgPath.cameraSvg,
            buttonText: 'Take Photo',
            onTap: () async {
              await imageController.takePhoto();
            },
          ),
          FoodEntryOptionCard(
            title: 'Scan Barcode',
            description: 'Scan food packaging to auto-fill nutrition info.',
            iconPath: SvgPath.barcodeSvg,
            buttonText: 'Scan',
            onTap: () {
              Get.to(() => const BarcodeScannerScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAllTabContent(FoodCaloriesController controller) {
    return GetBuilder<FoodCaloriesController>(
      builder: (controller) {
        return controller.isLoading
            ? Shimmer.fromColors(
              baseColor: AppColors.primary,
              highlightColor: AppColors.secondary,
              child: _buildFoodItems(controller),
            )
            : _buildFoodItems(controller);
      },
    );
  }

  ListView _buildFoodItems(FoodCaloriesController controller) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.foodsItems.length,
      itemBuilder: (context, index) {
        final item = controller.foodsItems[index];
        return GestureDetector(
          onTap: () => Get.to(() => FoodDetailsScreen(foodItem: item)),
          child: FoodItemCard(
            foodItem: item,
            onAdd: () => controller.addFoodItem(item),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTabContent(FoodCaloriesController controller) {
    final favoritesController = Get.find<FoodFavoritesController>();

    return Obx(() {
      if (favoritesController.favoriteItems.isEmpty) {
        return const Center(
          child: Text(
            'No favorites yet',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        );
      }

      return ListView.builder(
        itemCount: favoritesController.favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoritesController.favoriteItems[index];
          return GestureDetector(
            onTap: () => Get.to(() => FoodDetailsScreen(foodItem: item)),
            child: FoodItemCard(
              foodItem: item,
              onAdd: () => controller.addFoodItem(item),
            ),
          );
        },
      );
    });
  }
}
