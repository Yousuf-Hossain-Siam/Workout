import 'package:flutter/material.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/widgets/custom_text_field.dart';

class IngredientSection extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const IngredientSection({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.appbar,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredient',
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: AppColors.textWhite.withValues(alpha: 0.1),
            thickness: 1,
          ),
          CustomTextField(
            hintText: 'Add ingredient...',
            controller: controller,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
