import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/features/workout%20home/model/all_workout_model.dart';

class AllWorkoutController extends GetxController {
  final RxList<WorkoutModel> workoutList = <WorkoutModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> getAllWorkout() async {
    isLoading.value = true;
    EasyLoading.show(status: 'Loading');

    final response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.getAllworkout,
    );

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData['data'];
      workoutList.value =
          data.map<WorkoutModel>((e) => WorkoutModel.fromJson(e)).toList();
    } else {
      EasyLoading.showError(response.errorMessage ?? 'Something went wrong');
    }

    EasyLoading.dismiss();
    isLoading.value = false;
  }
}
