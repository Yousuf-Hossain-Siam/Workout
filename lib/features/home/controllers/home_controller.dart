import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController progressController;
  late Animation<double> progressAnimation;

  final RxDouble carbPercentage = 20.0.obs;
  final RxInt calories = 780.obs;
  final RxInt fats = 250.obs;
  final RxInt proteins = 39.obs;
  final RxInt carbs = 5.obs;

  @override
  void onInit() {
    super.onInit();
    progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    progressAnimation = CurvedAnimation(
      parent: progressController,
      curve: Curves.easeInOut,
    );

    // Start the animation when the screen loads
    progressController.forward();
  }

  @override
  void onClose() {
    progressController.dispose();
    super.onClose();
  }
}