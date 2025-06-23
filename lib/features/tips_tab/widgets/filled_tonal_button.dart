import 'package:flutter/material.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/sizer.dart';

class FilledTonalButton extends StatelessWidget {
  const FilledTonalButton({
    super.key,
    required this.icon,
    required this.text,
    this.isClicked,
    this.onClick,
  });

  final IconData icon;
  final String text;
  final bool? isClicked;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: Sizer.wp(88),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: ShapeDecoration(
          color: const Color(0xFF2A2F37),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isClicked ?? false ? Colors.yellow : Colors.white,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(text, style: getTextStyleInter(color: AppColors.textTitle)),
          ],
        ),
      ),
    );
  }
}
