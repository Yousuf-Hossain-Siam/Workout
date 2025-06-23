import 'package:luna_3/core/utils/jwt/verify_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static String? accessToken;
  static String? refreshToken;
  static bool? isEmailVerified;
  static bool? isWorkoutSettedup;

  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _isEmailVerifiedKey = 'isEmailVerified';
  static const String _isWorkoutSettedupKey = 'isWorkoutSettedup';

  static Future<void> saveAccessToken(String value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_accessTokenKey, value);
    accessToken = value;
  }

  static Future<void> saveRefreshToken(String value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_refreshTokenKey, value);
    refreshToken = value;
  }

  static Future<void> saveIsEmailVerified(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isEmailVerifiedKey, value);
    isEmailVerified = value;
  }

  static Future<void> saveIsWorkoutSettedup(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isWorkoutSettedupKey, value);
    isWorkoutSettedup = value;
  }

  static Future<void> getAllDataFromStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString(_accessTokenKey);
    final refreshToken = preferences.getString(_refreshTokenKey);
    final isEmailVerified = preferences.getBool(_isEmailVerifiedKey);
    final isWorkoutSettedup = preferences.getBool(_isWorkoutSettedupKey);

    if (token != null) {
      StorageService.accessToken = token;
    }
    if (refreshToken != null) {
      StorageService.refreshToken = refreshToken;
    }
    if (isEmailVerified != null) {
      StorageService.isEmailVerified = isEmailVerified;
    }
    if (isWorkoutSettedup != null) {
      StorageService.isWorkoutSettedup = isWorkoutSettedup;
    }
  }

  static Future<void> clearAllDataFromStorage() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_accessTokenKey);
    await preferences.remove(_refreshTokenKey);
    await preferences.remove(_isEmailVerifiedKey);
    await preferences.remove(_isWorkoutSettedupKey);
    accessToken = null;
    refreshToken = null;
    isEmailVerified = null;
    isWorkoutSettedup = null;
  }

  static Future<bool> isLoggedIn() async {
    await getAllDataFromStorage();
    if (accessToken != null &&
        accessToken!.isNotEmpty &&
        refreshToken != null &&
        refreshToken!.isNotEmpty) {
      bool isValidToken = verifyToken(accessToken!);
      bool isValidRefreshToken = verifyToken(refreshToken!);

      return isValidToken && isValidRefreshToken;
    }
    return false;
  }

  //! ===================================================================
  //! Depreciated and will be removed in the future
  //! ===================================================================
  // static UserModel? user;
  // static ProfileModel? profile;
  // static const String _userKey = 'user';
  // static const String _profileKey = 'profile';
  // static Future<void> saveAuthData({
  //   String? token,
  //   String? refreshToken,
  //   UserModel? user,
  //   ProfileModel? profile,
  // }) async {
  //   final preferences = await SharedPreferences.getInstance();
  //   if (token != null) {
  //     await preferences.setString(_accessTokenKey, token);
  //     StorageService.accessToken = token;
  //   }
  //   if (refreshToken != null) {
  //     await preferences.setString(_refreshTokenKey, refreshToken);
  //     StorageService.refreshToken = refreshToken;
  //   }
  //   if (user != null) {
  //     await preferences.setString(_userKey, jsonEncode(user.toJson()));
  //     StorageService.user = user;
  //   }
  //   if (profile != null) {
  //     await preferences.setString(_profileKey, jsonEncode(profile.toJson()));
  //     StorageService.profile = profile;
  //   }
  // }

  // static Future<void> loadAuthData() async {
  //   final preferences = await SharedPreferences.getInstance();

  //   final token = preferences.getString(_accessTokenKey);
  //   final refreshToken = preferences.getString(_refreshTokenKey);

  //   final userJson = preferences.getString(_userKey);
  //   final profileJson = preferences.getString(_profileKey);

  //   if (token != null) {
  //     StorageService.accessToken = token;
  //   }
  //   if (refreshToken != null) {
  //     StorageService.refreshToken = refreshToken;
  //   }
  //   if (userJson != null) {
  //     StorageService.user = UserModel.fromJson(jsonDecode(userJson));
  //   }
  //   if (profileJson != null) {
  //     StorageService.profile = ProfileModel.fromJson(jsonDecode(profileJson));
  //   }
  // }

  // // clear token and user from shared preferences
  // static Future<void> clearAuthData() async {
  //   final preferences = await SharedPreferences.getInstance();
  //   await preferences.remove(_accessTokenKey);
  //   await preferences.remove(_refreshTokenKey);
  //   await preferences.remove(_userKey);
  //   await preferences.remove(_profileKey);
  //   StorageService.accessToken = null;
  //   StorageService.refreshToken = null;
  //   StorageService.user = null;
  //   StorageService.profile = null;
  // }

  // static Future<void> logout() async {
  //   await clearAuthData();
  //   // Navigate to the login screen
  //   Get.offAllNamed(AppRoute.loginScreen);
  // }

  static bool hasToken() {
    final token = StorageService.accessToken;
    final refreshToken = StorageService.refreshToken;
    return token != null && refreshToken != null;
  }
}
