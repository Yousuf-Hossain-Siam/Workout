import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/features/home/view/home_navigation.dart';
import 'package:luna_3/features/profile/view/profile_screen.dart';
import 'package:luna_3/features/progress/view/progress_screen.dart';
import 'package:luna_3/features/tips_tab/view/tips_screen.dart';
import 'package:luna_3/features/workout%20home/view/workout_screen.dart';

class CustomBottomNavBarController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    HomeNavigation(),
    TipsScreen(),
    WorkoutScreen(isBottomNav: false),
    ProgressScreen(),
    ProfileScreen(),
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
