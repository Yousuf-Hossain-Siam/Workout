import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:luna_3/features/food_logging/models/food_item.dart';
import 'package:luna_3/features/food_logging/models/barcode_response.dart';

class FoodDataService {
  static const String _baseUrl =
      'https://world.openfoodfacts.org/sdapi/v0/product';

  Future<FoodItem?> getFoodByBarcode(String barcode) async {
    try {
      print('Attempting to fetch food data for barcode: $barcode');

      final url = '$_baseUrl/$barcode.json';
      print('Making API request to: $url');

      final response = await http.get(Uri.parse(url));
      print('API Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final barcodeResponse = BarcodeResponse.fromJson(data);

        if (barcodeResponse.status == 1 && barcodeResponse.product != null) {
          final product = barcodeResponse.product!;
          print('Found product data: ${product.productName}');

          final nutritionValues = product.getNutritionValues();

          return FoodItem(
            name: product.productName,
            barcode: barcode,
            brand: product.brands,
            servingSize: product.servingSize,
            servingUnit: product.servingUnit,
            calories: nutritionValues['calories'] ?? 0,
            carbs: nutritionValues['carbs'] ?? 0,
            protein: nutritionValues['protein'] ?? 0,
            fat: nutritionValues['fat'] ?? 0,
            fiber: nutritionValues['fiber'] ?? 0,
            description: product.ingredients,
            ingredients: product.ingredients,
            imageUrls: product.imageUrls,
          );
        } else {
          print('No product data found in the response');
          return null;
        }
      } else {
        print('API request failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching food data: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}
