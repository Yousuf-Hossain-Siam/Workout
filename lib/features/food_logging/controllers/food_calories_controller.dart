import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/features/food_logging/controllers/logged_food_controller.dart';
import 'package:luna_3/features/food_logging/models/food_calories_model.dart';
import 'package:luna_3/features/food_logging/models/food_item_model.dart';

class FoodCaloriesController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<FoodCaloriesModel> _foodCaloriesModel = [];
  List<FoodCaloriesModel> get foodsItems => _foodCaloriesModel;

  final RxList<FoodItem> allFoodItems = <FoodItem>[].obs;
  final RxList<FoodItem> filteredFoodItems = <FoodItem>[].obs;
  final RxString selectedTab = 'All'.obs;
  final RxString searchQuery = ''.obs;

  Future<bool> getAllFoods() async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    final response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.getAllFood,
    );
    if (response.isSuccess) {
      final List<dynamic> data = response.responseData['data'] as List<dynamic>;
      _foodCaloriesModel.clear();
      _foodCaloriesModel.addAll(
        data
            .map<FoodCaloriesModel>(
              (e) => FoodCaloriesModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      isSuccess = true;
      // EasyLoading.showSuccess('✅ ${response.responseData['message']}');
    } else {
      EasyLoading.showError(response.errorMessage ?? 'Something went wrong');
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Initialize with dummy data
  //   allFoodItems.value = [
  //     FoodItem(
  //       name: 'Chicken Provencal',
  //       calories: 780,
  //       imageUrl: ImagePath.chickenProvencal,
  //     ),
  //     FoodItem(
  //       name: 'Grilled Salmon',
  //       calories: 400,
  //       imageUrl: ImagePath.grilledSalmon,
  //     ),
  //     FoodItem(
  //       name: 'Spaghetti Carbonara',
  //       calories: 600,
  //       imageUrl: ImagePath.spaghettiCarbonara,
  //     ),
  //     FoodItem(
  //       name: 'Beef Burger (with bun)',
  //       calories: 300,
  //       imageUrl: ImagePath.beefBurger,
  //     ),
  //     FoodItem(
  //       name: 'Vegetable Stir-Fry',
  //       calories: 250,
  //       imageUrl: ImagePath.vegitable,
  //     ),
  //   ];
  //   filteredFoodItems.value = allFoodItems.toList();
  // }

  void changeTab(String tab) {
    selectedTab.value = tab;
    filterFoodItems();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterFoodItems();
  }

  void filterFoodItems() {
    var items = allFoodItems.toList();

    // Filter by tab
    switch (selectedTab.value) {
      case 'Manual':
        // Add created items filter logic
        break;
      case 'favorites':
        // Add favorites filter logic
        break;
      default: // 'All'
        // Show all items
        break;
    }

    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      items =
          items
              .where(
                (item) => item.name.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ),
              )
              .toList();
    }

    filteredFoodItems.value = items;
  }

  void addFoodItem(FoodCaloriesModel item) {
    final loggedFoodController = Get.find<LoggedFoodController>();
    loggedFoodController.addFoodItem(
      item.name ?? '',
      item.nutritionPerServing?.calories?.toInt() ?? 0,
    );
    Get.back(); // Return to food logging screen
  }
}
