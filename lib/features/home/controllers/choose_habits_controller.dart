import 'package:get/get.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';

class ChooseHabitsController extends GetxController {
  RxInt selectedTabIndex = 0.obs;
  final RxInt selectedHabitIndex = RxInt(-1);
  RxBool get showNextButton => (selectedHabitIndex.value >= 0).obs;

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  // Habit data
  final List<Map<String, String>> habits = [
    {
      'icon': SvgPath.protinSvg,
      'title': 'Eat more protein',
      'subtitle':
          'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
    },
    {
      'icon': SvgPath.waterSvg,
      'title': 'Drink more water',
      'subtitle':
          'Stay hydrated throughout the day for better health and energy.',
    },
    {
      'icon': SvgPath.fruitSvg,
      'title': 'Eat more fruit',
      'subtitle': 'Add natural sweetness and essential vitamins to your diet.',
    },
    {
      'icon': SvgPath.vegetablesSvg,
      'title': 'Eat more vegetables',
      'subtitle': 'Boost your nutrition with colorful and healthy vegetables.',
    },
    {
      'icon': SvgPath.mealLogSvg,
      'title': 'Log a daily meal',
      'subtitle': 'Track your nutrition to make better food choices.',
    },
    {
      'icon': SvgPath.fiberSvg,
      'title': 'Eat more fiber',
      'subtitle': 'Improve digestion and feel fuller for longer.',
    },
    {
      'icon': SvgPath.exerciseSvg,
      'title': 'Get more exercise',
      'subtitle': 'Move more to feel better and boost your energy.',
    },
    {
      'icon': SvgPath.alcoholSvg,
      'title': 'Drink less alcohol',
      'subtitle': 'Cut back on alcohol for better sleep and health.',
    },
    {
      'icon': SvgPath.sugerSvg,
      'title': 'Reduce added sugar',
      'subtitle':
          'Lower your sugar intake for better health and energy levels.',
    },
  ];

  void selectHabit(int index) {
    if (selectedHabitIndex.value == index) {
      selectedHabitIndex.value = -1;
    } else {
      selectedHabitIndex.value = index;
    }
  }

  String? getSelectedHabit() {
    if (selectedHabitIndex.value >= 0) {
      return habits[selectedHabitIndex.value]['title'];
    }
    return null;
  }

  
}
