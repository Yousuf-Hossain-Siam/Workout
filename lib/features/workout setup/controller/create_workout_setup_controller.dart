import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/features/profile/controller/profile_controller.dart';
import 'package:luna_3/features/main_layout/view/main_layout.dart';
import 'package:luna_3/features/workout%20setup/controller/workout_setup_controller.dart';

class CreateWorkoutSetupController extends GetxController {
  final WorkoutSetupController workoutSetupController = Get.find();

  final Map<String, dynamic> workoutSetupData = {};

  Future<void> createWorkoutSetup() async {
    EasyLoading.show(status: 'Loading...');
    Map<String, dynamic> requestBody = {
      "goal": workoutSetupController.selectedFitnessGoal.value,
      "gender": workoutSetupController.selectedGender.value,
      "weight": workoutSetupController.weightInKg.value,
      "age": workoutSetupController.age.value,
      "height": workoutSetupController.cmController.text,
      "dietaryPreference": workoutSetupController.selectedDiet.value,
      "exercisePreference": workoutSetupController.exercisePreference.value,
      "calorieGoal": workoutSetupController.calories.value,
      "sleepQuality": workoutSetupController.selectedSleepQuality.value,
    };

    final response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.workoutSetup,
      body: requestBody,
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess('✅ ${response.responseData['message']}');
      workoutSetupData.addAll(response.responseData);
      await Get.find<ProfileController>().getProfileData();
      Get.offAll(() => MainLayout());
    } else {
      EasyLoading.showError('❌ ${response.errorMessage}');
    }
    EasyLoading.dismiss();
  }
}
