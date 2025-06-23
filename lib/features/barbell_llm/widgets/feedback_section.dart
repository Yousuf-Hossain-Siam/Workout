import 'package:flutter/material.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';

class FeedbackSection extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onUpdate;

  const FeedbackSection({super.key, this.controller, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feedback',
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              hintText: 'e.g. make it shorter add more cardio no bench',
              hintStyle: getTextStyleWorkSans(
                color: AppColors.textSub,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColors.border, width: 0.4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColors.border, width: 0.4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onUpdate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(
                'Update Plan',
                style: getTextStyleWorkSans(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
