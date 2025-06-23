import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/home/controllers/choose_habits_controller.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({
    super.key,
    required this.index,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.controller,
  });

  final int index;
  final String icon;
  final String title;
  final String subtitle;
  final ChooseHabitsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedHabitIndex.value == index;
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Material(
          color: AppColors.appbar,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: () => controller.selectHabit(index),
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(icon),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: getTextStyleInter(
                          color: AppColors.textWhite,
                          fontSize: 18, 
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        subtitle,
                        style: getTextStyleInter(
                          color: AppColors.habitSub,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          lineHeight: 10,
                        ),
                      ),
                    ),
                    crossFadeState:
                        isSelected
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 200),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
