import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/services/storage_service.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/features/profile/models/profile_model.dart';

class ProfileController extends GetxController {
  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  // Profile Image
  final pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  // ------------------------------------------------------
  //! Get Profile Data
  // ------------------------------------------------------
  Future<void> getProfileData() async {
    EasyLoading.show(status: 'Loading...');
    final response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.getProfile,
    );

    if (response.isSuccess) {
      _profileModel = ProfileModel.fromJson(response.responseData['data']);
      await StorageService.saveIsWorkoutSettedup(true);
      // await StorageService.saveAuthData(profile: _profileModel);
    } else {
      EasyLoading.showError('❌ ${response.errorMessage}');
    }
    EasyLoading.dismiss();
  }

  void handlePickedImage(File imageFile) async {
    pickedImage.value = imageFile;
    EasyLoading.show(status: 'uploading...');
    final response = await Get.find<NetworkCaller>().multipartRequest(
      url: Urls.uploadOrChangeImg,
      jsonData: {},
      fileName: "files",
      image: XFile(imageFile.path),
    );
    if (response.isSuccess) {
      await getProfileData();
      EasyLoading.showSuccess('✅ Image uploaded successfully');
    } else {
      pickedImage.value = null;
      EasyLoading.showError('❌ Failed to upload image');
    }
    EasyLoading.dismiss();
  }

  // ------------------------------------------------------
  //! update profile data
  // ------------------------------------------------------
  Future<bool> updateProfileData({required Map<String, dynamic> data}) async {
    EasyLoading.show(status: 'Loading...');
    final response = await Get.find<NetworkCaller>().patchRequest(
      url: Urls.updateProfileData,
      body: data,
    );

    if (response.isSuccess) {
      await getProfileData();
      EasyLoading.showSuccess('✅ Profile updated successfully');
      return true;
    } else {
      EasyLoading.showError('❌ ${response.errorMessage}');
      return false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (image != null) {
        pickedImage.value = File(image.path);
        handlePickedImage(File(image.path));
      }
      Get.back(); // Close bottom sheet
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
