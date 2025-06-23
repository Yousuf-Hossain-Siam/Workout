import 'package:flutter/material.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';

class HabitTipSection extends StatelessWidget {
  const HabitTipSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '⚡ Tip: Make it easy with habit stacking. Pair your new habit with something you already do every day.',
      style: getTextStyleWorkSans(
        color: AppColors.textWhite,
        lineHeight: 12,
        fontSize: 14,
      ),
    );
  }
}
