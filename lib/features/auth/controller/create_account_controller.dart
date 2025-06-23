import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/services/storage_service.dart';
import 'package:luna_3/core/utils/constants/app_texts.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';
import 'package:luna_3/features/auth/models/create_account_model.dart';
import 'package:luna_3/features/auth/view/otp_verification_screen.dart';

class CreateAccountController extends GetxController {
  var createAccountModel =
      CreateAccountModel(
        splashIcon: IconPath.splashicon,
        emailIcon: IconPath.emailicon,
        passwordIcon: IconPath.passwordicon,
        eyeIcon: 'assets/icons/Solid eye.png',
        title: AppText.createaccountScreentitle,
        subtitle: AppText.createaccountScreensubtitle,
        usernameLabel: AppText.createaccountScreenuser,
        emailLabel: AppText.createaccountScreenemail,
        passwordLabel: AppText.createaccountScreenpassword,
        confirmPasswordLabel: AppText.createaccountconfirmpassword,
        alreadyHaveAccount: AppText.createaccountalreadyhaveaccount,
        signInText: AppText.createaccountsignin,
      ).obs;

  // Profile Image
  final pickedImage = Rx<File?>(null);

  // Controllers for each field
  late GlobalKey<FormState> formKey;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void handlePickedImage(File imageFile) async {
    pickedImage.value = imageFile;
  }

  RxBool isLoading = false.obs;
  Rx<String?> errorMessage = Rx<String?>(null);

  // Separate password visibility states
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  // Toggle functions for each
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  //? ----------------------------------------------------
  // * Function to handle sign up
  //? ----------------------------------------------------
  Future<void> onClickSignUp() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'loading...');
      isLoading.value = true;

      Map<String, dynamic> requestBody = {
        "name": usernameController.text,
        // "phone": "015xxxxxxxx",
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text,
        "email": emailController.text,
        "aggriedToTerms": true,
      };

      final response = await Get.find<NetworkCaller>().multipartRequest(
        url: "https://luna3server.onrenderer.com/api/v1/users/createUser",
        jsonData: requestBody,
        image: XFile(pickedImage.value!.path),
      );

      if (response.isSuccess) {
        if (response.responseData['data']['token'] != null) {
          await StorageService.saveAccessToken(
            response.responseData['data']['token'],
          );
          EasyLoading.showSuccess('✅ ${response.errorMessage}.');
          Get.to(() => OtpVerificationScreen(email: emailController.text));
        } else {
          EasyLoading.showError("❌ ${response.errorMessage}.");
        }
      } else {
        EasyLoading.showError("❌ ${response.errorMessage}.");
      }
    }

    EasyLoading.dismiss();
  }

  // Dispose controllers when not needed
  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
