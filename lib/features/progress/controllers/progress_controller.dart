import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController progressAnimation;
  late Animation<double> progressBarAnimation;

  final RxDouble carbPercentage = 10.0.obs;
  final RxInt calories = 780.obs;
  final RxInt fats = 250.obs;
  final RxInt proteins = 39.obs;
  final RxInt carbs = 5.obs;

  // Weekly data for the chart
  final RxList<Map<String, dynamic>> weeklyData =
      <Map<String, dynamic>>[
        {'day': 'SUN', 'value': 0.6},
        {'day': 'MON', 'value': 0.9},
        {'day': 'TUE', 'value': 0.5},
        {'day': 'WED', 'value': 0.3},
        {'day': 'THU', 'value': 0.7},
        {'day': 'FRI', 'value': 0.8},
        {'day': 'SAT', 'value': 0.4},
      ].obs;

  @override
  void onInit() {
    super.onInit();
    progressAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    progressBarAnimation = CurvedAnimation(
      parent: progressAnimation,
      curve: Curves.easeInOut,
    );

    // Start the animation
    progressAnimation.forward();
  }

  @override
  void onClose() {
    progressAnimation.dispose();
    super.onClose();
  }

  void updateProgress(double percentage) {
    carbPercentage.value = percentage;
    progressAnimation.reset();
    progressAnimation.forward();
  }
}
