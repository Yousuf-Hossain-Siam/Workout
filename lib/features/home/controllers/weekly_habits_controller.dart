import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklyHabitsController extends GetxController {
  // Notification toggle state
  final RxBool isNotificationEnabled = true.obs;

  // Selected time
  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  // Selected days for notifications
  final RxList<int> selectedDays = <int>[].obs;

  // Toggle notification
  void toggleNotification(bool value) {
    isNotificationEnabled.value = value;
  }

  // Update selected time
  void updateTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  // Toggle day selection
  void toggleDaySelection(int day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  // Format time for display
  String getFormattedTime() {
    final hour = selectedTime.value.hour;
    final minute = selectedTime.value.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour > 12 ? hour - 12 : hour;
    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute $period';
  }

  // Get day name
  String getDayName(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
