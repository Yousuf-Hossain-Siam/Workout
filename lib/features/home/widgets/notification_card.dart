import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/home/controllers/weekly_habits_controller.dart';

class NotificationCard extends StatelessWidget {
  final WeeklyHabitsController controller;

  const NotificationCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
      decoration: BoxDecoration(
        color: AppColors.appbar,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          _buildNotificationToggle(),
          Divider(
            color: AppColors.textWhite.withValues(alpha: .28),
            thickness: 0.9,
            height: 32,
          ),
          _buildReminderTime(),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Push notifications',
                style: getTextStyleWorkSans(
                  color: AppColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Habit reminders turned on',
                style: getTextStyleWorkSans(
                  color: AppColors.textWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              activeTrackColor: AppColors.secondary,
              activeColor: AppColors.textWhite,
              inactiveTrackColor: Colors.grey[400],
              value: controller.isNotificationEnabled.value,
              onChanged: controller.toggleNotification,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderTime() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Reminder time',
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () => _showTimePicker(Get.context!, controller),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                controller.getFormattedTime(),
                style: getTextStyleWorkSans(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTimePicker(
    BuildContext context,
    WeeklyHabitsController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.selectedTime.value,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.appbar,
              hourMinuteTextColor: AppColors.textWhite,
              dialBackgroundColor: AppColors.background,
              dialTextColor: AppColors.textWhite,
              dialHandColor: AppColors.primary,
              entryModeIconColor: AppColors.textWhite,
              dayPeriodColor: AppColors.background,
              dayPeriodTextColor: AppColors.textWhite,
              confirmButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(AppColors.textWhite),
                textStyle: WidgetStateProperty.all(
                  getTextStyleWorkSans(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              cancelButtonStyle: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(AppColors.textWhite),
                textStyle: WidgetStateProperty.all(
                  getTextStyleWorkSans(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              dayPeriodTextStyle: getTextStyleWorkSans(
                color: AppColors.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              helpTextStyle: getTextStyleWorkSans(
                color: AppColors.textWhite,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              hourMinuteTextStyle: getTextStyleWorkSans(
                color: AppColors.textWhite,
                fontSize: 38,
                fontWeight: FontWeight.w500,
              ),
              hourMinuteColor: AppColors.background,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.updateTime(picked);
    }
  }
}
