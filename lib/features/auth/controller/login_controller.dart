import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/services/storage_service.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/core/utils/constants/app_texts.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';
import 'package:luna_3/features/auth/models/LoginResponseModel.dart';
import 'package:luna_3/features/auth/models/login_model.dart';
import 'package:luna_3/features/auth/view/send_otp_to_your_email_screen.dart';
import 'package:luna_3/features/main_layout/view/main_layout.dart';
import 'package:luna_3/features/profile/controller/profile_controller.dart';
import 'package:luna_3/features/workout%20setup/controller/get_workout_setup_controller.dart';
import 'package:luna_3/features/workout%20setup/view/app_setup_screen_1.dart';

class LoginController extends GetxController {
  var loginModel =
      LoginModel(
        splashIcon: IconPath.splashicon,
        emailIcon: IconPath.emailicon,
        passwordIcon: IconPath.passwordicon,
        eyeIcon: 'assets/icons/Solid eye.png',
        loginTitle: AppText.loginScreentitle,
        loginSubtitle: AppText.loginScreensubtitle,
        emailLabel: AppText.loginScreenemail,
        passwordLabel: AppText.loginScreenpassword,
        forgotPassword: AppText.loginForgetpassword,
      ).obs;

  late GlobalKey<FormState> formKey;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  //* --------------- login with email and password ----------------
  Future<void> onClickSignIn() async {
    if (formKey.currentState?.validate() ?? false) {
      EasyLoading.show(status: 'loading...');
      Map<String, dynamic> requestBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      final response = await Get.find<NetworkCaller>().postRequest(
        url: Urls.login,
        body: requestBody,
        needToken: false,
      );

      if (response.isSuccess) {
        final data = LoginResponseModel.fromJson(response.responseData);

        if (data.approvalToken != null && data.refreshToken != null) {
          await StorageService.saveAccessToken(data.approvalToken!);
          await StorageService.saveRefreshToken(data.refreshToken!);
        }

        // check is user email verified
        if (data.user?.OTPverified != true) {
          await StorageService.saveIsEmailVerified(false);
          EasyLoading.showError('Please verify your email to login');
          Get.to(
            () => SendOtpToYourEmailScreen(
              email: emailController.text,
              approvalToken: data.approvalToken,
            ),
          );
        } else {
          await StorageService.saveIsEmailVerified(true);
          await Get.find<ProfileController>().getProfileData();
          EasyLoading.show(status: 'loading Workout Setup data...');
          final isWorkoutSetup =
              await Get.find<GetWorkoutSetupController>().getWorkoutSetup();
          EasyLoading.showSuccess('Login successful');
          if (isWorkoutSetup) {
            await StorageService.saveIsWorkoutSettedup(true);
            Get.offAll(() => MainLayout());
          } else {
            await StorageService.saveIsWorkoutSettedup(false);
            Get.offAll(() => AppSetupScreen1());
          }
        }
      } else {
        EasyLoading.showError(response.errorMessage ?? '❌ Login failed');
      }
    }

    EasyLoading.dismiss();
  }

  //! --------------- login with social media ----------------
  Future<void> socialAuthentication({
    required String email,
    required String method,
  }) async {
    EasyLoading.show(status: 'loading...');
    Map<String, dynamic> requestBody = {"email": email, "method": method};

    final response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.login,
      body: requestBody,
    );

    if (response.isSuccess) {
      final data = LoginResponseModel.fromJson(response.responseData);
      // save token and refresh token to shared preferences
      await StorageService.saveAccessToken(data.approvalToken!);
      await StorageService.saveRefreshToken(data.refreshToken!);
      // save token and data to shared preferences
      // await StorageService.saveAuthData(
      //   token: data.approvalToken,
      //   refreshToken: data.refreshToken,
      //   user: data.user,
      // );
      // check is user email verified
      if (data.user?.OTPverified != true) {
        EasyLoading.showError('Please verify your email to login');
        Get.to(
          () => SendOtpToYourEmailScreen(
            email: emailController.text,
            approvalToken: data.approvalToken,
          ),
        );
      } else {
        EasyLoading.showSuccess('Login successful');
        await Get.find<ProfileController>().getProfileData();
        Get.offAll(() => AppSetupScreen1());
      }
    } else {
      EasyLoading.showError(response.errorMessage ?? '❌ Login failed');
    }

    EasyLoading.dismiss();
  }
}
