// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:luna_3/core/utils/constants/colors.dart';
// import 'package:luna_3/features/add/view/add_screen.dart';
// import 'package:luna_3/features/home/view/home_navigation.dart';
// import 'package:luna_3/features/profile/view/profile_screen.dart';
// import 'package:luna_3/features/progress/view/progress_screen.dart';
// import 'package:luna_3/features/tips_tab/view/tips_screen.dart';

// class NavController extends GetxController {
//   final RxInt selectedIndex = 0.obs;

//   void changePage(int index) {
//     selectedIndex.value = index;
//   }
// }

// class CustomBottomNavBar extends StatelessWidget {
//   const CustomBottomNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final NavController controller = Get.put(NavController());

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: Obx(() => _buildCurrentScreen(controller.selectedIndex.value)),
//       bottomNavigationBar: _buildBottomNavBar(controller),
//     );
//   }

//   Widget _buildCurrentScreen(int index) {
//     final List<Widget> screens = [
//       HomeNavigation(),
//       TipsScreen(),
//       AddScreen(),
//       ProgressScreen(),
//       ProfileScreen(),
//     ];
//     return screens[index];
//   }

//   Widget _buildBottomNavBar(NavController controller) {
//     return Container(
//       height: 98,
//       decoration: const BoxDecoration(
//         color: Color(0xFF1C2227),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(21),
//           topRight: Radius.circular(21),
//         ),
//         boxShadow: [
//           BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2),
//         ],
//       ),
//       child: SafeArea(
//         child: Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(
//                 'Home',
//                 'assets/icons/home.png',
//                 0,
//                 controller.selectedIndex.value,
//                 controller,
//               ),
//               _buildNavItem(
//                 'Tips Tab',
//                 'assets/icons/tipstab.png',
//                 1,
//                 controller.selectedIndex.value,
//                 controller,
//               ),
//               _buildAddButton(controller),
//               _buildNavItem(
//                 'Progress',
//                 'assets/icons/progress.png',
//                 3,
//                 controller.selectedIndex.value,
//                 controller,
//               ),
//               _buildNavItem(
//                 'Profile',
//                 'assets/icons/profile.png',
//                 4,
//                 controller.selectedIndex.value,
//                 controller,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(
//     String title,
//     String imagePath,
//     int index,
//     int selectedIndex,
//     NavController controller,
//   ) {
//     final bool isSelected = selectedIndex == index;

//     return InkWell(
//       onTap: () => controller.changePage(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(7),
//             decoration: BoxDecoration(
//               color: isSelected ? const Color(0xFFEAFF55) : Color(0xFF2B2F33),
//               shape: BoxShape.circle,
//             ),
//             child: Image.asset(
//               imagePath,
//               width: 24,
//               height: 24,
//               color: isSelected ? Colors.black : Colors.white,
//               fit: BoxFit.contain,
//             ),
//           ).paddingOnly(top: 15),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.white,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddButton(NavController controller) {
//     return InkWell(
//       onTap: () => controller.changePage(2),
//       child: Container(
//         padding: const EdgeInsets.all(1),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//         child: const Icon(Icons.add, color: Colors.black, size: 40),
//       ),
//     );
//   }
// }
