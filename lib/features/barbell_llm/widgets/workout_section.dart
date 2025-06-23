import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';

class WorkoutSection extends StatelessWidget {
  final String icon;
  final String title;
  final String content;
  final EdgeInsetsGeometry? padding;
  final String? subTitle;

  const WorkoutSection({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.border, width: 0.4),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          SvgPicture.asset(icon, width: 66, height: 66),

          Text(
            title,
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subTitle ?? '',
            textAlign: TextAlign.center,
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              lineHeight: 12,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.center,
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              lineHeight: 12,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          SvgPicture.asset(SvgPath.divider, width: 200),
        ],
      ),
    );
  }
}
