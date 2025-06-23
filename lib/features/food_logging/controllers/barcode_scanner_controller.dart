import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/features/food_logging/models/food_item.dart';
import 'package:luna_3/features/food_logging/services/food_data_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:luna_3/features/food_logging/view/food_scan_details_screen.dart';
import 'package:logger/logger.dart';

class BarcodeScannerController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final logger = Logger();

  final _foodItem = Rxn<FoodItem>();
  FoodItem? get foodItem => _foodItem.value;

  final _foodDataService = FoodDataService();
  final _isProcessing = false.obs;
  final _lastScannedBarcode = ''.obs;
  final _lastScanTime = 0.obs;

  static const int _minimumScanInterval = 2000; // 2 seconds in milliseconds

  Future<void> handleBarcodeScan(String barcode) async {
    // Check if this is a duplicate scan within the minimum interval
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (barcode == _lastScannedBarcode.value &&
        currentTime - _lastScanTime.value < _minimumScanInterval) {
      logger.d('Ignoring duplicate scan within $_minimumScanInterval ms');
      return;
    }

    // Prevent multiple simultaneous scans
    if (_isProcessing.value || _isLoading.value) {
      logger.d('Scan already in progress, ignoring new scan');
      return;
    }

    try {
      logger.d('Starting barcode scan process for barcode: $barcode');
      _isProcessing.value = true;
      _isLoading.value = true;
      _lastScannedBarcode.value = barcode;
      _lastScanTime.value = currentTime;

      logger.d('Fetching food data from service...');
      final food = await _foodDataService.getFoodByBarcode(barcode);

      if (food != null) {
        logger.d('Food data found: ${food.name}');
        _foodItem.value = food;
        Get.off(() => FoodScanDetailsScreen(foodItem: food));
      } else {
        logger.d('No food data found for barcode: $barcode');
        Get.snackbar(
          'Product Not Found',
          'No food information found for this barcode. Please try again or add manually.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(8),
          borderRadius: 8,
        );
      }
    } catch (e, stackTrace) {
      logger.e('Error in handleBarcodeScan: $e');
      logger.e('Stack trace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to process barcode. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        borderRadius: 8,
      );
    } finally {
      logger.d('Scan process completed');
      _isLoading.value = false;
      _isProcessing.value = false;
    }
  }

  Future<bool> checkCameraPermission() async {
      logger.d('Checking camera permission...');
    final status = await Permission.camera.status;
    logger.d('Current camera permission status: $status');

    if (status.isDenied) {
      logger.d('Camera permission is denied, requesting permission...');
      final result = await Permission.camera.request();
      logger.d('Permission request result: $result');
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      logger.d('Camera permission is permanently denied');
      Get.dialog(
        AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Camera permission is required for barcode scanning. Please enable it in settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      return false;
    }

    logger.d('Camera permission is granted');
    return status.isGranted;
  }
}
