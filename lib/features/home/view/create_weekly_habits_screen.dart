import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/home/controllers/choose_habits_controller.dart';
import 'package:luna_3/features/home/controllers/habit_state_controller.dart';
import 'package:luna_3/features/home/controllers/weekly_habits_controller.dart';
import 'package:luna_3/features/home/widgets/day_selector.dart';
import 'package:luna_3/features/home/widgets/habbit_button.dart';
import 'package:luna_3/features/home/widgets/habit_tip_section.dart';
import 'package:luna_3/features/home/widgets/notification_card.dart';
import 'package:luna_3/features/home/widgets/weekly_habits_header.dart';

class CreateWeeklyHabitsScreen extends StatelessWidget {
  static const String routeName = '/weekly_habits';
  const CreateWeeklyHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeeklyHabitsController());
    final chooseHabitsController = Get.find<ChooseHabitsController>();
    final habitStateController = Get.find<HabitStateController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              CustomAppBar(
                title: 'Weekly habits',
                showNotification: false,
                showCalendarIcon: true,
                showBackButton: true,
                onCalendarPressed: () => _showDaySelector(context, controller),
              ),
              const SizedBox(height: 20),

              // Header with title and description
              const WeeklyHabitsHeader(),
              const SizedBox(height: 12),

              // Notification settings card
              NotificationCard(controller: controller),
              const SizedBox(height: 24),

              // Tip section
              const HabitTipSection(),
              const Spacer(),

              // Save button
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomHabitButton(
                  showButton: true.obs,
                  onPressed: () {
                    final selectedHabit =
                        chooseHabitsController.getSelectedHabit();
                    if (selectedHabit != null) {
                      habitStateController.addHabit(selectedHabit);
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  buttonText: 'Save',
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showDaySelector(
    BuildContext context,
    WeeklyHabitsController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DaySelector(controller: controller),
    );
  }
}
