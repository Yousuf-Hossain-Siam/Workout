// lib/services/google_auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX for navigation and snackbars
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luna_3/features/auth/controller/login_controller.dart'; // For Colors in snackbar

// Import your AppSetupScreen1 here as the service will now handle navigation to it.
// Adjust the path if your AppSetupScreen1 is located elsewhere.

class GoogleAuthService {
  static Future<UserCredential?> signInWithGoogleAndNavigate() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in process
        debugPrint('Google sign-in cancelled by user.');
        Get.snackbar(
          'Sign-in Cancelled',
          'Google sign-in was cancelled. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blueGrey,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // If sign-in is successful, navigate to AppSetupScreen1
      if (userCredential.user != null) {
        // --- MODIFIED HERE: Removed 'result' and 'loginMethod' arguments ---
        Get.find<LoginController>().socialAuthentication(
          email: googleUser.email,
          method: "google",
        );
        // ------------------------------------------------------------------
      }

      return userCredential; // Return the UserCredential
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors (e.g., account already exists, wrong credentials)
      debugPrint(
        'Firebase Auth Error during Google sign-in: ${e.code} - ${e.message}',
      );
      String errorMessage;
      if (e.code == 'account-exists-with-different-credential') {
        errorMessage =
            'An account already exists with the same email address but different sign-in credentials. Please use the original sign-in method.';
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
      // Handle any other unexpected errors during the process
      debugPrint('Unexpected error during Google login: $e');
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
