import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/utils/constants/app_texts.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';

class WorkoutSetupController extends GetxController {
  TextEditingController feetController = TextEditingController();
  TextEditingController cmController = TextEditingController();

  RxString selectedFitnessGoal = ''.obs;
  RxString selectedGender = ''.obs;
  RxDouble weightInKg = 66.0.obs; // Weight is always stored internally in KG
  RxInt age = 18.obs; // in years
  // height value is stored in cmController.text
  RxString selectedDiet = ''.obs;
  RxString exercisePreference = ''.obs;
  RxDouble calories = 1550.0.obs; // Observed variable for calories
  RxString selectedSleepQuality = ''.obs;

  // -------- Workout Setup 1 -------- //
  Map<String, String> fitnessGoals = {
    'lose_weight': "I wanna lose weight",
    'gain_weight': "I want to gain strength",
    'ai_coach': "I wanna try AI Coach",
    'gain_insurance': "I wanna gain endurance",
    'just_tryout_app': "Just trying out the app!",
  };

  void selectFitnessGoal(String goal) {
    selectedFitnessGoal.value = goal;
  }

  bool isSelectedFitnessGoal(String value) {
    return selectedFitnessGoal.value == value;
  }

  // -------- Workout Setup 2 -------- //
  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  // -------- Workout Setup 3 -------- //
  RxBool isKgSelected = true.obs; // Unit toggle: true = KG, false = LB

  void toggleUnit() {
    isKgSelected.value = !isKgSelected.value;
  }

  String get currentUnit =>
      isKgSelected.value
          ? AppText.appsetup3Screenkg
          : AppText.appsetup3Screenlb;

  double get weightInLbs => weightInKg.value * 2.20462; // weight

  double get displayedWeight =>
      isKgSelected.value ? weightInKg.value : weightInLbs;

  void updateWeight(double value) {
    if (isKgSelected.value) {
      if (value >= 30 && value <= 150) {
        weightInKg.value = value;
      }
    } else {
      final kg = value / 2.20462;
      if (kg >= 30 && kg <= 150) {
        weightInKg.value = kg;
      }
    }
  }

  // -------- Workout Setup 5 -------- //

  void updateHeight(double value, {bool isFeet = false}) {
    if (isFeet) {
      cmController.text = (value * 30.48).toInt().toDouble().floor().toString();
    } else {
      feetController.text = (value / 30.48).toStringAsFixed(1);
    }
  }

  // -------- Workout Setup 6 -------- //

  // final selectedDiet = ''.obs;

  void selectDiet(String dietName) {
    selectedDiet.value = convertToUnderscoreLowercase(dietName);
    // print(selectedDiet.value);
  }

  bool isSelectedDiet(String dietName) => selectedDiet.value == dietName;

  bool get isAnySelected => selectedDiet.value.isNotEmpty;

  // -------- Workout Setup 7 -------- //
  List<Map<String, String>> data = [
    {'title': 'Jogging', 'icon': IconPath.jogging},
    {'title': 'Walking', 'icon': IconPath.walking},
    {'title': 'Hiking', 'icon': IconPath.hiking},
    {'title': 'Skating', 'icon': IconPath.skaing},
    {'title': 'Biking', 'icon': IconPath.biking},
    {'title': 'Weight Lift', 'icon': IconPath.lifting},
    {'title': 'Cardio', 'icon': IconPath.cardio},
    {'title': 'Yoga', 'icon': IconPath.yoga},
    {'title': 'Other', 'icon': IconPath.other},
  ];

  List<Widget> rows = [];

  var selectedIndex = RxInt(-1); // -1 means no card selected

  void selectCard(int index) {
    selectedIndex.value = index;
    exercisePreference.value = toCamelCase(data[index]['title'] ?? '');
  }

  // -------- Workout Setup 8 -------- //

  final double minCalories = 1000; // Minimum calorie value
  final double maxCalories = 3000; // Maximum calorie value

  void updateCalories(double newValue) {
    calories.value = newValue; // Update the observed value
  }

  // -------- Workout Setup 9 -------- //
  void selectSleepQuality(String sleepQuality) {
    selectedSleepQuality.value = sleepQuality;
    // print(selectedSleepQuality.value);
  }

  bool isSelectedSleepQuality(String buttonKey) {
    return selectedSleepQuality.value == buttonKey;
  }

  String toCamelCase(String input) {
    if (input.isEmpty) return input;

    // Split into words, handle various separators
    final words = input.split(RegExp(r'[_\s-]'));

    // First word in lowercase
    final firstWord = words[0].toLowerCase();

    // Capitalize remaining words
    final restWords = words.skip(1).map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    });

    return firstWord + restWords.join();
  }

  String convertToUnderscoreLowercase(String input) {
    // Handle empty string
    if (input.isEmpty) return input;

    // Replace hyphens and spaces with underscores
    String withUnderscores = input.replaceAll(RegExp(r'[-\s]'), '_');

    // Convert to lowercase
    return withUnderscores.toLowerCase();
  }
}
