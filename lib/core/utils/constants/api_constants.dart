class Urls {
  static const String baseUrl = "https://luna3server.onrenderreer.com/api/v1";

  // users
  static const String getProfile = "$baseUrl/users/getProfile";
  static const String createAccount = "$baseUrl/users/createUser";
  static const String workoutSetup = "$baseUrl/users/createWorkoutSetup";
  static const String getWorkoutSetup = "$baseUrl/users/getWorkoutSetup";
  static const String uploadOrChangeImg = "$baseUrl/users/uploadOrChangeImg";
  static const String updateProfileData = "$baseUrl/users/updateProfileData";

  // auth
  static const String login = "$baseUrl/auth/login";
  static const String sendOtp = "$baseUrl/auth/send_OTP";
  static const String resendOtp = "$baseUrl/auth/reSend_OTP";
  static const String verifyOtp = "$baseUrl/auth/otpcrossCheck";
  static const String logout = "$baseUrl/auth/logout";
  static const String forgetPassword = "$baseUrl/auth/forgetPassword";
  static const String resetPassword = "$baseUrl/auth/resetPassword";

  // workdout
  static const String getAllworkout =
      "$baseUrl/exercise/getExerciseBothCommonAndPersonalize";
  static const String postWorkoutTimer = "$baseUrl/exercise/performExercise?";
  static const String patchMarkExercise =
      "$baseUrl/markExerciseAsCompleated?performedExerciseId=684fe3504160e46c05e1225e";

  /// ------------------------ Food Logging ------------------------
  static const String addPersonalizeFoodManually =
      "$baseUrl/foods/addPersonalizeFoodManually";
  static const String getAllFood = "$baseUrl/foods/getAllFood";
  static String addNutrients({required String consumedAs, String? foodId}) =>
      "$baseUrl/foods/addConsumedFoodFromImgOrQRCodeOrFoodId?consumedAs=$consumedAs";
}
