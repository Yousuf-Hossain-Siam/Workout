import 'package:get/get.dart';
import 'package:luna_3/features/food_logging/models/food_calories_model.dart';

class FoodFavoritesController extends GetxController {
  final RxList<FoodCaloriesModel> favoriteItems = <FoodCaloriesModel>[].obs;

  void toggleFavorite(FoodCaloriesModel foodItem) {
    final existingItem = favoriteItems.firstWhereOrNull(
      (element) => element.name == foodItem.name,
    );

    if (existingItem != null) {
      favoriteItems.remove(existingItem);
    } else {
      favoriteItems.add(foodItem);
    }
  }

  bool isFavorite(FoodCaloriesModel foodItem) {
    return favoriteItems.any((element) => element.name == foodItem.name);
  }
}
