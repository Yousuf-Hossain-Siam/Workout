// lib/services/facebook_auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:get/get.dart'; // Import GetX for navigation and snackbars
import 'package:flutter/material.dart';
import 'package:luna_3/features/workout%20setup/view/app_setup_screen_1.dart'; // Adjust the path if your AppSetupScreen1 is located elsewhere.


class FacebookAuthService {
  static Future<UserCredential?> signInWithFacebookAndNavigate() async {
    try {
      // Trigger the Facebook sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        // You can specify permissions here, e.g., ['email', 'public_profile']
        permissions: ['email', 'public_profile'],
      );

      // Handle different login statuses
      if (loginResult.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

        // Sign in with Firebase using the Facebook credential
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

        // If sign-in is successful, navigate to AppSetupScreen1
        if (userCredential.user != null) {
          Get.to(() => AppSetupScreen1());
        }

        return userCredential; // Return the UserCredential
      } else if (loginResult.status == LoginStatus.cancelled) {
        debugPrint('Facebook sign-in cancelled by user.');
        Get.snackbar(
          'Sign-in Cancelled',
          'Facebook sign-in was cancelled. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blueGrey,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return null;
      } else if (loginResult.status == LoginStatus.failed) {
        debugPrint('Facebook sign-in failed: ${loginResult.message}');
        Get.snackbar(
          'Sign-in Failed',
          'Facebook sign-in failed: ${loginResult.message ?? 'Unknown error'}.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        return null;
      } else {
        // Handle other unexpected statuses
        debugPrint('Unexpected Facebook login status: ${loginResult.status}');
        Get.snackbar(
          'Error',
          'An unexpected error occurred during Facebook sign-in. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
        return null;
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors
      debugPrint('Firebase Auth Error during Facebook sign-in: ${e.code} - ${e.message}');
      String errorMessage;
      if (e.code == 'account-exists-with-different-credential') {
        errorMessage = 'An account already exists with the same email address but different sign-in credentials. Please use the original sign-in method.';
      } else {
        errorMessage = 'Authentication error: ${e.message ?? 'Unknown error'}.';
      }
      Get.snackbar(
        'Sign-in Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      return null;
    } catch (e) {
      // Handle any other unexpected errors
      debugPrint('Unexpected error during Facebook login: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      return null;
    }
  }
}