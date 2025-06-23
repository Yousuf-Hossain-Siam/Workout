import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/controllers/custom_bottom_nav_bar_controller.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomBottomNavBarController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        return controller.screens[controller.selectedIndex.value];
      }),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
