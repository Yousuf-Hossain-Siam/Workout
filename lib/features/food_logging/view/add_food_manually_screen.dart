import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/add_food_manually_controller.dart';
import 'package:luna_3/features/food_logging/widgets/custom_text_field.dart';
import 'package:luna_3/features/food_logging/widgets/food_image_upload_widget.dart';
import 'package:luna_3/features/food_logging/widgets/food_name_field.dart';
import 'package:luna_3/features/food_logging/widgets/ingredient_section.dart';
import 'package:luna_3/features/food_logging/widgets/instructions_section.dart';
import 'package:luna_3/features/food_logging/widgets/nutrients_per_serving_section.dart';
import 'package:luna_3/features/food_logging/widgets/track_button.dart';

class AddFoodManuallyScreen extends GetView<AddFoodManuallyController> {
  static const routeName = '/add-food-manually';
  const AddFoodManuallyScreen({super.key, this.isCreate = true});

  final bool isCreate;

  @override
  Widget build(BuildContext context) {
    final addFoodManuallyController = Get.put(AddFoodManuallyController());
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      appBar: AppBarWidget(
        title: isCreate ? 'Create Food' : 'Add Nutrients',
        showNotification: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isCreate)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      //* ------------------ Image Upload Section ------------------
                      FoodImageUploadWidget(
                        controller: addFoodManuallyController.imageController,
                      ),
                      const SizedBox(height: 20),

                      //* ------------------ Name Field ------------------
                      FoodNameField(
                        controller: addFoodManuallyController.nameController,
                      ),
                      const SizedBox(height: 20),

                      //* ------------------ Ingredient Section ------------------
                      IngredientSection(
                        controller:
                            addFoodManuallyController.ingredientsController,
                      ),
                      const SizedBox(height: 20),

                      //* ------------------ Instructions Section ------------------
                      InstructionsSection(
                        controller:
                            addFoodManuallyController.instructionsController,
                        onChanged: (value) {
                          addFoodManuallyController
                              .instructionsController
                              .text = value;
                        },
                      ),
                      const SizedBox(height: 20),

                      //* ------------------ Servings Field ------------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appbar,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Servings',
                              style: getTextStyleWorkSans(
                                color: AppColors.textWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: CustomTextField(
                                hintText: '01',
                                controller:
                                    addFoodManuallyController
                                        .servingsController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      //* ------------------ Preparation Time Field ------------------
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appbar,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Preparation Time',
                              style: getTextStyleWorkSans(
                                color: AppColors.textWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: CustomTextField(
                                hintText: '0 Min',
                                controller:
                                    addFoodManuallyController
                                        .prepTimeController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                //* ------------------ Nutrients Per Serving Section ------------------
                NutrientsPerServingSection(
                  // controllers: addFoodManuallyController.nutrientControllers,
                  // onChanged: addFoodManuallyController.nutrientOnChange,
                ),
                const SizedBox(height: 30),

                //* ------------------ Save Button ------------------
                TrackButton(
                  text: isCreate ? 'Create' : 'Add',
                  onTap: () {
                    if (isCreate) {
                      addFoodManuallyController.createPersonalFoodItem();
                    } else {
                      addFoodManuallyController.onClickedAddNutrients();
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
