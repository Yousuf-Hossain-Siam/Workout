import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';
import 'package:luna_3/features/barbell_llm/controllers/barbell_llm_controller.dart';
import 'package:luna_3/features/barbell_llm/view/workout_plan_screen.dart';

class WorkoutPlanForm extends StatelessWidget {
  final BarbellLLMController controller;

  const WorkoutPlanForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Fitness Goal Field
        _buildInputField(
          controller: controller.fitnessGoalController,
          hintText: 'e.g. strength, hypertrophy, endurance',
          label: 'Fitness goal',
          icon: SvgPath.fitnessgoalSvg,
        ),
        const SizedBox(height: 20),

        // Experience Level Field
        _buildInputField(
          controller: controller.experienceLevelController,
          hintText: 'e.g. beginner, intermediate,advance',
          label: 'Experience level',
          icon: SvgPath.experienceLevelSvg,
        ),
        const SizedBox(height: 20),

        // Available Equipment Field
        _buildInputField(
          controller: controller.equipmentController,
          hintText: 'e.g. dumbbells, barbell,bands',
          label: 'Available equipment',
          icon: SvgPath.availableEquipmentSvg,
        ),
        const SizedBox(height: 30),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            Get.to(() => const WorkoutPlanScreen());
          },
          child: Obx(() {
            return controller.isLoading.value
                ? const CircularProgressIndicator(color: Colors.black)
                : const Text(
                  'Generate Plan',
                  style: TextStyle(color: Colors.black),
                );
          }),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String label,
    required String icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyleWorkSans(color: AppColors.textWhite, fontSize: 18),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: getTextStyleWorkSans(color: AppColors.textWhite, fontSize: 16),
          decoration: InputDecoration(
            fillColor: AppColors.background,
            hintText: hintText,
            hintStyle: getTextStyleWorkSans(
              color: const Color(0xff8B8B8B),
              fontSize: 14,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(icon, width: 24, height: 24),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.border, width: 0.9),
              gapPadding: 0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.border, width: 0.9),
              gapPadding: 0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.border, width: 0.9),
              gapPadding: 0,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          ),
        ),
      ],
    );
  }
}
