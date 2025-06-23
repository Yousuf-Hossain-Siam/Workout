import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/sizer.dart';
import 'package:luna_3/features/auth/view/login_screen.dart';

import '../controller/onboarding_controller.dart';
import '../widgets/continue_button.dart';

class OnboardingScreen4 extends StatelessWidget {
  OnboardingScreen4({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final r = ResponsiveHelper(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(controller.onboarding4.value.imagePath),
            fit: BoxFit.fill,
          ),
          color: AppColors.backgroundDark, // Fallback color
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: Sizer.hp(50)),
          child: Column(
            children: [
              //* ---------------- Skip button ---------------- */
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 32.0,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    controller.onboarding4.value.skipText,
                    style: getTextStyle1(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),
              Spacer(),
              // Obx(
              //   () => Image.asset(
              //     controller.onboarding4.value.imagePath,
              //     fit: BoxFit.fill,
              //     width: double.infinity,
              //     height: double.infinity,
              //     errorBuilder: (context, error, stackTrace) {
              //       return Image.network(
              //         'https://picsum.photos/id/505/320/750',
              //         fit: BoxFit.fill,
              //         width: double.infinity,
              //         height: double.infinity,
              //       );
              //     },
              //   ),
              // ),

              // Background header bar
              // Positioned(
              //   top: r.fromSmallMediumLarge(
              //     small: size.height / 50,
              //     medium: size.height / 45,
              //     large: size.height / 40,
              //   ),
              //   child: Container(
              //     height: r.fromSmallMediumLarge(
              //       small: size.height / 40,
              //       medium: size.height / 35,
              //       large: size.height / 32,
              //     ),
              //     width: size.width,
              //     color: AppColors.backgroundDark,
              //   ),
              // ),

              //* ---------------- Skip button ---------------- */
              // Positioned(
              //   top: r.fromSmallMediumLarge(
              //     small: size.height / 22,
              //     medium: size.height / 20,
              //     large: size.height / 18,
              //   ),
              //   right: r.fromSmallMediumLarge(
              //     small: size.width / 18,
              //     medium: size.width / 15,
              //     large: size.width / 12,
              //   ),
              //   child: Obx(
              //     () => Text(
              //       controller.onboarding4.value.skipText,
              //       style: getTextStyle1(
              //         fontSize: 20,
              //         fontWeight: FontWeight.w500,
              //         color: AppColors.secondary,
              //       ),
              //     ),
              //   ),
              // ),

              //* ---------------- Title ---------------- */
              Text.rich(
                TextSpan(
                  style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  children: [
                    const TextSpan(text: 'Your path to '),
                    const TextSpan(
                      text: 'success',
                      style: TextStyle(color: Color(0xFFEAFF55)),
                    ),
                    const TextSpan(text: '\nwith start daily tracking'),
                  ],
                ),
              ),

              SizedBox(height: Sizer.hp(73)),

              // Positioned(
              //   bottom: r.fromSmallMediumLarge(
              //     small: size.height / 4.8,
              //     medium: size.height / 4.3,
              //     large: size.height / 4.0,
              //   ),
              //   left: r.fromSmallMediumLarge(
              //     small: size.width / 20,
              //     medium: size.width / 12,
              //     large: size.width / 10,
              //   ),
              //   child: Text.rich(
              //     TextSpan(
              //       style: GoogleFonts.nunito(
              //         fontSize: 30,
              //         fontWeight: FontWeight.w700,
              //         color: Colors.white,
              //       ),
              //       children: [
              //         const TextSpan(text: 'Your path to '),
              //         const TextSpan(
              //           text: 'success',
              //           style: TextStyle(color: Color(0xFFEAFF55)),
              //         ),
              //         const TextSpan(text: '\nwith start daily tracking'),
              //       ],
              //     ),
              //   ),
              // ),

              //* ---------------- Get Started button ---------------- */
              ContinueButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                buttonText: "Get Started",
                showLeftIcon: true,
                showRightArrow: true,
                enableSwipe: true,
                useExternalSwipe: true, // Use the external swipe animation
              ),

              // Positioned(
              //   bottom: r.fromSmallMediumLarge(
              //     small: size.height / 12,
              //     medium: size.height / 15,
              //     large: size.height / 9,
              //   ),
              //   left: r.fromSmallMediumLarge(
              //     small: size.width / 19,
              //     medium: size.width / 20,
              //     large: size.width / 12,
              //   ),
              //   child: ContinueButton(
              //     onPressed: () {
              //       Get.to(() => LoginScreen());
              //     },
              //     buttonText: "Get Started",
              //     showLeftIcon: true,
              //     showRightArrow: true,
              //     enableSwipe: true,
              //     useExternalSwipe: true, // Use the external swipe animation
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
