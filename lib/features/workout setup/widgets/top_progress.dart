import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/app_texts.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/workout%20setup/controller/top_progress_controller.dart';

class TopProgress extends StatelessWidget {
  const TopProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final setupController = Get.find<TopProgressController>();

    return Row(
      children: [
        // Back Button
        IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondary, size: 30),
          onPressed: () {
            Get.back(); // Go to previous screen
            setupController.goToPreviousStep(); // Decrease step count
          },
        ),

        const SizedBox(width: 8),

        // Progress Bar
        Expanded(
          child: SizedBox(
            height: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => LinearProgressBar(
                  maxSteps: 7, // or total number of screens
                  currentStep: setupController.currentStep.value,
                  progressType: LinearProgressBar.progressTypeLinear,
                  progressColor: AppColors.secondary,
                  backgroundColor: AppColors.progressbar,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Skip Button
        TextButton(
          onPressed: () {
            setupController.currentStep.value = 6; // Skip to last step
          },
          child: Text(
            AppText.skip,
            style: getTextStyle1(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.transparent,
                height: 1.90,
            ),
          ),
        ).paddingOnly(right: 8),
      ],
    );
  }
}
