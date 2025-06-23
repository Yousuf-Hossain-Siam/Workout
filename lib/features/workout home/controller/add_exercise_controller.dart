// add_asset_controller.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luna_3/core/services/network_caller.dart';

class AddExercisecontroller extends GetxController {
  Rx<File?> pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController exerciseDescriptionController = TextEditingController();
  TextEditingController primaryMuscleGroupController = TextEditingController();
  TextEditingController exerciseTypeController = TextEditingController();

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickedImage.value = File(image.path);
        Get.snackbar("Success", "Image uploaded successfully");
      } else {
        Get.snackbar("Info", "No image selected");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: ${e.toString()}");
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedImage.value = File(image.path);
        Get.snackbar("Success", "Image uploaded successfully");
      } else {
        Get.snackbar("Info", "No image selected");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: ${e.toString()}");
    }
  }

  Future<void> onClickSaveExercise() async {
    EasyLoading.show(status: 'Uploading...');

    final response = await Get.find<NetworkCaller>().multipartRequest(
      url:
          'https://luna3server.onrenderrr.com/api/v1/exercise/createPersonalizeExercise',
      jsonData: {
        'name': exerciseNameController.text,
        'description': exerciseDescriptionController.text,
        'primaryMuscleGroup': primaryMuscleGroupController.text,
        'exerciseType': exerciseTypeController.text,
      },
      image: XFile(pickedImage.value!.path),
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess('✅ ${response.responseData['message']}');
    } else {
      EasyLoading.showError(response.errorMessage ?? 'Something went wrong');
    }

    EasyLoading.dismiss();
  }

  // // Show bottom sheet to choose source
  // void showImageSourcePicker(BuildContext context) {
  //   Get.bottomSheet(
  //     Container(
  //       padding: const EdgeInsets.all(20),
  //       decoration: BoxDecoration(
  //         color: AppColors.appbar,
  //         borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           // Title
  //           Text(
  //             'Add Photo',
  //             style: getTextStyleWorkSans(
  //               color: AppColors.textWhite,
  //               fontSize: 18,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           const SizedBox(height: 20),

  //           // Options Row
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               _buildOptionButton(
  //                 icon: Icons.camera_alt_rounded,
  //                 label: 'Camera',
  //                 onTap: () {
  //                   Get.back();
  //                   pickImage(ImageSource.camera);
  //                 },
  //               ),
  //               _buildOptionButton(
  //                 icon: Icons.photo_library_rounded,
  //                 label: 'Gallery',
  //                 onTap: () {
  //                   Get.back();
  //                   pickImage(ImageSource.gallery);
  //                 },
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 24),

  //           // Cancel Button
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               onPressed: () => Get.back(),
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: AppColors.appbar.withValues(alpha: 0.2),
  //                 padding: const EdgeInsets.symmetric(vertical: 16),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //               ),
  //               child: const Text('Cancel'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     backgroundColor: Colors.transparent,
  //     isDismissible: true,
  //     enableDrag: true,
  //   );
  // }

  // Widget _buildOptionButton({
  //   required IconData icon,
  //   required String label,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Column(
  //       children: [
  //         Container(
  //           width: 60,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             color: AppColors.appbar.withValues(alpha: 0.2),
  //             shape: BoxShape.circle,
  //           ),
  //           child: Icon(icon, color: AppColors.textWhite, size: 28),
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           label,
  //           style: getTextStyleWorkSans(
  //             color: AppColors.textWhite,
  //             fontSize: 14,
  //             fontWeight: FontWeight.w400,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // // Pick image from given source
  // Future<void> pickImage(ImageSource source) async {
  //   try {
  //     final XFile? image = await _picker.pickImage(
  //       source: source,
  //       imageQuality: 80,
  //     );
  //     if (image != null) {
  //       pickedImage.value = File(image.path);
  //     }
  //   } catch (e) {
  //     debugPrint("Image picking error: $e");
  //   }
  // }
}
