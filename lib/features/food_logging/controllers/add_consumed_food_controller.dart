import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';

class AddConsumedFoodController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  //? -----------------------------------------
  // Add nutrients
  //? -----------------------------------------
  Future<bool> addConsumedFood({
    required String consumedAs,
    required Map<String, dynamic> requestBody,
  }) async {
    print("Consumed as: $consumedAs");
    print("Request body: $requestBody");
    _isLoading = true;
    bool isSuccess = false;
    update();

    final response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.addNutrients(consumedAs: consumedAs),
      body: requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Something went wrong';
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
