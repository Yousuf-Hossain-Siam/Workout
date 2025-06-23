import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/barbell_llm/controllers/barbell_llm_controller.dart';
import 'package:luna_3/features/barbell_llm/widgets/ask_barbell_card.dart';
import 'package:luna_3/features/barbell_llm/widgets/workout_plan_card.dart';
import 'package:luna_3/features/barbell_llm/widgets/workout_plan_form.dart';
import 'package:luna_3/features/barbell_llm/view/ask_barbell_chat_screen.dart';

class BarbellLLMScreen extends StatelessWidget {
  static const String routeName = '/barbell-llm';
  const BarbellLLMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarbellLLMController());

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              CustomAppBar(
                title: 'Barbell LLM',
                showNotification: true,
                showBackButton: true,
              ),

              const SizedBox(height: 20),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Option Cards
                      Row(
                        children: [
                          Expanded(
                            child: AskBarbellCard(
                              onTap:
                                  () => Get.to(
                                    () => const AskBarbellChatScreen(),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: WorkoutPlanCard(
                              onTap: controller.onWorkoutPlanTap,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 48),

                      // Workout Plan Creation Form
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Workout Plan Creation',
                          style: getTextStyleWorkSans(
                            color: AppColors.textWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Workout Plan Form
                      WorkoutPlanForm(controller: controller),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
