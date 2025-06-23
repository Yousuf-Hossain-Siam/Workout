import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/features/food_logging/controllers/add_consumed_food_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_image_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_logging_controller.dart';
import 'package:luna_3/features/food_logging/enums/food_loggin_enums.dart';
import 'package:luna_3/features/food_logging/models/food_item.dart';

class AddFoodManuallyController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  // ------------------- Nutrients controllers -------------------
  final TextEditingController energyController = TextEditingController(
    text: '0.0',
  );
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController fiberController = TextEditingController();

  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final imageController = Get.find<FoodImageController>();

  void calculateEnergy() {
    double energy = 0.0;
    energy += (double.tryParse(carbsController.text) ?? 0.0) * 4;
    energy += (double.tryParse(proteinController.text) ?? 0.0) * 4;
    energy += (double.tryParse(fatController.text) ?? 0.0) * 9;
    energy += (double.tryParse(fiberController.text) ?? 0.0) * 2;
    energyController.text = energy.toStringAsFixed(1);
    update();
  }

  //? -----------------------------------------
  // Add nutrients
  //? -----------------------------------------
  Future<bool> onClickedAddNutrients() async {
    print("Start adding");
    return await Get.find<AddConsumedFoodController>().addConsumedFood(
      consumedAs: Get.find<FoodLoggingController>().consumedAs.value.name,
      requestBody: {
        "calories": double.parse(energyController.text),
        "protein": double.parse(proteinController.text),
        "carbs": double.parse(carbsController.text),
        "fats": double.parse(fatController.text),
        "fiber": double.parse(fiberController.text),
      },
    );
  }

  //? -----------------------------------------
  // Create personal food item
  //? -----------------------------------------
  Future<void> createPersonalFoodItem() async {
    final AddConsumedFoodController addConsumedFoodController =
        Get.find<AddConsumedFoodController>();
    await addConsumedFoodController.addConsumedFood(
      consumedAs: FoodLogginEnums.lunch.name,
      requestBody: {
        "calories": double.parse(energyController.text),
        "protein": double.parse(proteinController.text),
        "carbs": double.parse(carbsController.text),
        "fats": double.parse(fatController.text),
        "fiber": double.parse(fiberController.text),
      },
    );
  }

  //? -----------------------------------------
  // Save food item
  //? -----------------------------------------
  void saveFoodItem() {
    try {
      final foodItem = FoodItem(
        name: nameController.text,
        barcode: '', // Empty for manually added items
        brand: '', // Empty for manually added items
        servingSize: double.tryParse(servingsController.text) ?? 1,
        servingUnit: 'g',
        calories: double.tryParse(energyController.text) ?? 0,
        carbs: double.tryParse(carbsController.text) ?? 0,
        protein: double.tryParse(proteinController.text) ?? 0,
        fat: double.tryParse(fatController.text) ?? 0,
        fiber: double.tryParse(fiberController.text) ?? 0,
        description: '', // Empty for manually added items
        ingredients: ingredientsController.text,
        imageUrls:
            imageController.imagePath != null
                ? [imageController.imagePath!]
                : [],
      );
      Get.back(result: foodItem);
    } catch (e) {
      print('Error saving food item: $e');
      Get.snackbar(
        'Error',
        'Failed to save food item. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  //? -----------------------------------------
  // Dispose
  //? -----------------------------------------
  @override
  void onClose() {
    nameController.dispose();
    servingsController.dispose();
    prepTimeController.dispose();
    ingredientsController.dispose();
    instructionsController.dispose();
    energyController.dispose();
    carbsController.dispose();
    proteinController.dispose();
    fatController.dispose();
    fiberController.dispose();
    super.onClose();
  }
}
