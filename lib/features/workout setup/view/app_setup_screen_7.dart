import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/app_texts.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/workout setup/controller/top_progress_controller.dart';
import 'package:luna_3/features/workout setup/widgets/button.dart';
import 'package:luna_3/features/workout setup/widgets/top_progress.dart';
import 'package:luna_3/features/workout%20setup/controller/workout_setup_controller.dart';
import 'package:luna_3/features/workout%20setup/view/app_setup_screen_8.dart';
import 'package:luna_3/features/workout%20setup/widgets/exercise_card.dart';

class AppSetupScreen7 extends StatelessWidget {
  const AppSetupScreen7({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutSetupController = Get.find<WorkoutSetupController>();
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            TopProgress(),
            SizedBox(height: 40),
            Text(
              AppText.appsetup7Screentitle,
              style: getTextStyle1(
                fontSize: 28,
                color: AppColors.textWhite,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 20),
            ..._buildCardRows(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => Button(
                    onPressed:
                        workoutSetupController.selectedIndex.value != -1
                            ? () {
                              final setupController =
                                  Get.find<TopProgressController>();
                              setupController.goToNextStep();
                              Get.to(() => AppSetupScreen8());
                            }
                            : null,
                    text: AppText.appsetup1Screenpoin6,
                    fontSize: 20,
                    alignment: Alignment.center,
                    fontWeight: FontWeight.w500,
                    backgroundColor:
                        workoutSetupController.selectedIndex.value != -1
                            ? AppColors.appbar
                            : Colors.grey,
                    textColor: AppColors.textWhite,
                    selectedColor: AppColors.appbar,
                    selectedTextColor: AppColors.textWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCardRows() {
    final workoutSetupController = Get.find<WorkoutSetupController>();
    List<Map<String, String>> data = workoutSetupController.data;
    if (workoutSetupController.rows.isEmpty) {
      for (int i = 0; i < data.length; i += 3) {
        workoutSetupController.rows.add(
          Row(
            children: [
              for (int j = 0; j < 3 && i + j < data.length; j++) ...[
                ExerciseCard(
                  index: i + j,
                  title: data[i + j]['title']!,
                  iconPath: data[i + j]['icon']!,
                ),
                if (j != 2 && i + j + 1 < data.length)
                  const SizedBox(width: 10),
              ],
            ],
          ).paddingOnly(left: 20, top: 10),
        );
      }
    }
    return workoutSetupController.rows;
  }
}
