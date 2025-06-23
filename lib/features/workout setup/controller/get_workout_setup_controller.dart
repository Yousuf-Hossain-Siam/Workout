import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/services/storage_service.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';

class GetWorkoutSetupController extends GetxController {
  //* --------------- Retrive workout setup ----------------
  Future<bool> getWorkoutSetup() async {
    EasyLoading.show();
    final response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.getWorkoutSetup,
    );
    EasyLoading.dismiss();
    if (response.isSuccess) {
      await StorageService.saveIsWorkoutSettedup(true);
      EasyLoading.dismiss();
      return true;
    } else {
      await StorageService.saveIsWorkoutSettedup(false);
      EasyLoading.dismiss();
      return false;
    }
  }
}
