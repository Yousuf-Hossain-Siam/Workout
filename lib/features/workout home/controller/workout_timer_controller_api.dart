import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/features/workout%20home/model/workout_timer_model.dart';

class workoutTimerController extends GetxController {
  final RxList<WorkoutTimerModel> workoutList = <WorkoutTimerModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // postWorkoutTimer(); // Fetch data automatically when controller initializes
  }

  Future<void> postWorkoutTimer() async {
    isLoading.value = true;
    EasyLoading.show(status: 'Loading');

    final response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.postWorkoutTimer,
    );

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData['data'];
      workoutList.value =
          data
              .map<WorkoutTimerModel>((e) => WorkoutTimerModel.fromJson(e))
              .toList();
    } else {
      EasyLoading.showError(response.errorMessage ?? 'Something went wrong');
    }

    EasyLoading.dismiss();
    isLoading.value = false;
  }
}
