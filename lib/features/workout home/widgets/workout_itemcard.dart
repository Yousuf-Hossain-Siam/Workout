import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';

class WorkoutItem {
  final String name;
  final String imageUrl;
  final String subname;

  WorkoutItem({
    required this.name,
    required this.imageUrl,
    required this.subname,
  });
}

// CONTROLLER embedded here
class WorkoutCardController extends GetxController {
  var selectedIndex = RxInt(-1);

  void toggleSelection(int index) {
    selectedIndex.value = selectedIndex.value == index ? -1 : index;
  }
}

// ITEM CARD
class WorkoutItemcard extends StatelessWidget {
  final WorkoutItem workoutItem;
  final int index;
  final VoidCallback onAdd;

  WorkoutItemcard({
    super.key,
    required this.workoutItem,
    required this.index,
    required this.onAdd,
  });

  final WorkoutCardController controller = Get.put(WorkoutCardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;

      return GestureDetector(
        onTap: () => controller.toggleSelection(index),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.appbar,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSelected)
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 60,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ).marginOnly(top: 4),

              if (isSelected) const SizedBox(width: 6),

              // Image
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: workoutItem.imageUrl.startsWith('http')
                      ? Image.network(
                          workoutItem.imageUrl,
                          height: MediaQuery.of(context).size.height / 17,
                          width: MediaQuery.of(context).size.width / 7,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 8,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error_outline, color: Colors.red),
                            );
                          },
                        )
                      : Image.asset(
                          workoutItem.imageUrl,
                          height: MediaQuery.of(context).size.height / 16,
                          width: MediaQuery.of(context).size.width / 8,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 8,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error_outline, color: Colors.red),
                            );
                          },
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      workoutItem.name,
                      style: getTextStyleWorkSans(
                        color: AppColors.textWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      workoutItem.subname,
                      style: getTextStyleWorkSans(
                        color: AppColors.textWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Add button
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: onAdd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Add',
                      style: getTextStyleWorkSans(
                        color: AppColors.textfieldBackground,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
