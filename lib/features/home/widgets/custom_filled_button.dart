
import 'package:flutter/material.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/home/controllers/choose_habits_controller.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.controller,
    required this.title,
    required this.index,
  });

  final ChooseHabitsController controller;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        controller.selectTab(index);
      },
      style: FilledButton.styleFrom(
        backgroundColor:
            controller.selectedTabIndex.value == index
                ? AppColors.secondary
                : AppColors.textFieldFill,
        foregroundColor:
            controller.selectedTabIndex.value == index
                ? AppColors.textFieldFill
                : AppColors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(title),
    );
  }
}
