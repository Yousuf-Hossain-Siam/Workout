import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/app_texts.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/workout%20setup/widgets/calorie_screen.dart';
import 'package:luna_3/features/workout%20setup/controller/top_progress_controller.dart';
import 'package:luna_3/features/workout%20setup/widgets/button.dart';
import 'package:luna_3/features/workout%20setup/widgets/top_progress.dart';
import 'package:luna_3/features/workout%20setup/view/app_setup_screen_9.dart';

class AppSetupScreen8 extends StatelessWidget {
  const AppSetupScreen8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            TopProgress(),
            const SizedBox(height: 30),
            Text(
              AppText.appsetup8Screentitle,
              style: getTextStyle1(
                fontSize: 28,
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
                //  lineHeight: 38 ,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 10),
            CalorieScreen(),
            SizedBox(height: MediaQuery.of(context).size.height / 8.5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Button(
                  onPressed: () {
                    final setupController = Get.find<TopProgressController>();
                    setupController.goToNextStep(); // Increase progress
                    Get.to(() => SleepQualityScreen());
                  },
                  text: AppText.appsetup1Screenpoin6,
                  fontSize: 20,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.w500,
                  backgroundColor: AppColors.appbar,
                  textColor: AppColors.textWhite,
                  selectedColor: AppColors.appbar,
                  selectedTextColor: AppColors.textWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
