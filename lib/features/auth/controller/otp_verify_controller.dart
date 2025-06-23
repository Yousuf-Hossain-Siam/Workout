import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/services/storage_service.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/core/utils/constants/app_texts.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';
import 'package:luna_3/features/auth/models/otp_verify_screen_model.dart';
import 'package:luna_3/features/auth/view/login_screen.dart';
import 'package:luna_3/features/auth/view/new_password_screen.dart';

class OtpVerifyController extends GetxController {
  var otpModel =
      OtpVerifyScreenModel(
        splashIcon: IconPath.splashicon,
        title: AppText.forgotpassScreentitle,
        subtitle: AppText.forgotpassotpScreensubtitle,
      ).obs;

  TextEditingController otpController = TextEditingController();

  RxBool canResend = false.obs;
  var resendDuration = 20.obs;
  final countdownKey = UniqueKey().obs;

  void onResend() {
    resendOtp();
    countdownKey.value = UniqueKey();
  }

  //? ----------------------------------------------------
  // * Function to verify OTP
  //? ----------------------------------------------------
  Future<void> verifyOtp({bool isResetPassword = false}) async {
    EasyLoading.show(status: 'loading...');
    Map<String, dynamic> requestBody = {
      "recivedOTP": otpController.text,
      "token": StorageService.accessToken,
    };
    if (isResetPassword) {
      requestBody['passwordChange'] = true;
    }
    final response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.verifyOtp,
      body: requestBody,
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess('✅ ${response.responseData['message']}');
      if (isResetPassword) {
        Get.to(() => NewPasswordScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    } else {
      EasyLoading.showError(response.errorMessage ?? 'Something went wrong');
    }
  }

  //? ----------------------------------------------------
  // * Function to resend OTP
  //? ----------------------------------------------------
  Future<void> resendOtp() async {
    EasyLoading.show(status: 'loading...');

    final response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.resendOtp,
      body: {},
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess('✅ ${response.responseData['message']}');
      canResend.value = false;
    } else {
      EasyLoading.showError(response.errorMessage ?? 'Something went wrong');
    }

    EasyLoading.dismiss();
  }
}
