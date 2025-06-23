import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/common/widgets/search_input_decoration.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/workout%20home/controller/all_workout_controller.dart';
import 'package:luna_3/features/workout%20home/view/add_exercise_screen.dart';
import 'package:luna_3/features/workout%20home/view/workout_timer_1.dart';
import 'package:luna_3/features/workout%20home/widgets/workout_itemcard.dart';

class AllWorkoutScreen extends StatelessWidget {
  const AllWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllWorkoutController controller = Get.put(AllWorkoutController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: 'All Exercise',
                  showBackButton: true, // Show back button
                  showNotification: true, // Show notification icon
                  onBackPressed: () {
                    Get.back(); // Navigate back when back button is pressed
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 150),
                TextField(decoration: searchTextfeildDecoration()),
                // Search Bar
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Exercise",
                      style: getTextStyle1(
                        fontSize: 18,
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AddExerciseScreen());
                      },
                      child: Text(
                        "Create",
                        style: getTextStyle1(
                          fontSize: 18,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),

                // -------------------------------------------------------------
                             
                Obx(() {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final workout = controller.workoutList[index];
                      return WorkoutItemcard(
                        workoutItem: WorkoutItem(
                          name: workout.name ?? "",
                          imageUrl: workout.img ?? "",
                          subname: workout.exerciseType ?? "",
                        ),
                        onAdd: () {
                          Get.to(WorkoutTimer1(index: index));
                        }, index: index,
                        
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8);
                    },
                    itemCount: controller.workoutList.length,
                  );
                }),
                // -------------------------------------------------------------
                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       barrierDismissible: true,
                //       barrierColor: Colors.transparent,
                //       builder:
                //           (context) => PopUpButton(
                //             onTap: () {
                //               Get.to(() => WorkoutTimer1());
                //             },
                //           ),
                //     );
                //   },
                //   child: WorkoutItemcard(
                //     workoutItem: WorkoutItem(
                //       name: 'Morning Run',
                //       imageUrl: 'assets/images/bicep.png',
                //       subname: "Biceps",
                //     ),
                //     onAdd: () {
                //       Get.to(WorkoutTimer1());
                //     },
                //   ),
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 90),
                // WorkoutItemcard(
                //   workoutItem: WorkoutItem(
                //     name: 'Back Extension',
                //     imageUrl: 'assets/images/back ex.png',
                //     subname: "Hyperextension",
                //   ),
                //   onAdd: () {
                //     Get.to(WorkoutTimer1());
                //   },
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 90),
                // WorkoutItemcard(
                //   workoutItem: WorkoutItem(
                //     name: 'Ball Slams',
                //     imageUrl: 'assets/images/ball slam.png',
                //     subname: "Full Body",
                //   ),
                //   onAdd: () {
                //     Get.to(WorkoutTimer1());
                //   },
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 90),
                // WorkoutItemcard(
                //   workoutItem: WorkoutItem(
                //     name: 'Arnold Press',
                //     imageUrl: 'assets/images/arnold press.png',
                //     subname: "Dumbbell",
                //   ),
                //   onAdd: () {
                //     Get.to(WorkoutTimer1());
                //   },
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 90),
                // WorkoutItemcard(
                //   workoutItem: WorkoutItem(
                //     name: 'Around The World',
                //     imageUrl: 'assets/images/around the world.png',
                //     subname: "Chest",
                //   ),
                //   onAdd: () {
                //     Get.to(WorkoutTimer1());
                //   },
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 90),
                // WorkoutItemcard(
                //   workoutItem: WorkoutItem(
                //     name: 'Pistol',
                //     imageUrl: 'assets/images/pistol sqa.png',
                //     subname: "Quadriceps",
                //   ),
                //   onAdd: () {
                //     Get.to(WorkoutTimer1());
                //   },
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height / 90),
                // WorkoutItemcard(
                //   workoutItem: WorkoutItem(
                //     name: 'Morning Run',
                //     imageUrl: 'assets/images/bicep.png',
                //     subname: "Biceps",
                //   ),
                //   onAdd: () {
                //     Get.to(WorkoutTimer1());
                //   },
                // ),

                // Search Bar
              ],
            ),
          ),
        ),
      ),
    );
  }
}
