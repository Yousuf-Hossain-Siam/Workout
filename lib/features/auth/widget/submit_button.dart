import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/utils/constants/colors.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: Get.height / 15,
        width: Get.width / 1.1,
        decoration: BoxDecoration(
          color: AppColors.secondary, // Replace with AppColors.secondary if needed
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}