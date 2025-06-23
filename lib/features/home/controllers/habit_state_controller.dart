import 'package:get/get.dart';

class HabitStateController extends GetxController {
  final RxInt habitsCount = 0.obs;
  final RxString selectedHabit = ''.obs;

  void addHabit(String habitTitle) {
    habitsCount.value++;
    selectedHabit.value = habitTitle;
  }

  String getHabitCardTitle() {
    if (habitsCount.value == 0) {
      return 'Choose your next habits';
    }
    return '${habitsCount.value} Habits added';
  }

  String getHabitCardSubtitle() {
    if (habitsCount.value == 0) {
      return 'Big goals start with small habits.';
    }
    return selectedHabit.value;
  }
}
