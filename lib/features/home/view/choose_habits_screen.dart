import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/home/controllers/choose_habits_controller.dart';
import 'package:luna_3/features/home/view/create_weekly_habits_screen.dart';
import 'package:luna_3/features/home/widgets/habbit_button.dart';
import 'package:luna_3/features/home/widgets/habit_tile.dart';

class ChooseHabitsScreen extends StatelessWidget {
  static const String routeName = '/choose_habits';
  ChooseHabitsScreen({super.key});

  final controller = Get.put(ChooseHabitsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(
        title: 'Choose your next habits',
        showBackButton: true,
        showNotification: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildTabBarButtons(),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  if (controller.selectedTabIndex.value == 1) {
                    return const Center(child: Text('Create Habit'));
                  }
                  return _buildChooseHabitSection(context);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildChooseHabitSection(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ...List.generate(
                controller.habits.length,
                (index) => HabitTile(
                  index: index,
                  icon: controller.habits[index]['icon']!,
                  title: controller.habits[index]['title']!,
                  subtitle: controller.habits[index]['subtitle']!,
                  controller: controller,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Obx(
          () => CustomHabitButton(
            showButton: controller.showNextButton,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateWeeklyHabitsScreen(),
                ),
              );
            },
            buttonText: 'Next',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTabBarButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.selectTab(0),
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        controller.selectedTabIndex.value == 0
                            ? AppColors.primary
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Choose Habit',
                      style: TextStyle(
                        color:
                            controller.selectedTabIndex.value == 0
                                ? Colors.white
                                : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.selectTab(1),
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        controller.selectedTabIndex.value == 1
                            ? AppColors.primary
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Create Habit',
                      style: TextStyle(
                        color:
                            controller.selectedTabIndex.value == 1
                                ? Colors.white
                                : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
