import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';

// Controller
class RestTimerController extends GetxController {
  RxInt selectedTime = 15.obs;

  void updateTime(int time) {
    selectedTime.value = time;
  }
}

class RestTimerBottomSheet extends StatelessWidget {
  final Function(int) onTimeSelected;
  final int initialTime;

  const RestTimerBottomSheet({
    super.key,
    required this.onTimeSelected,
    this.initialTime = 15,
  });

  @override
  Widget build(BuildContext context) {
    final RestTimerController controller = Get.put(RestTimerController());
    controller.selectedTime.value = initialTime;

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: AppColors.appbar,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 150,
            decoration: BoxDecoration(
              color: AppColors.textWhite,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 16),

          Text(
            'REST TIMER',
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '21s Bicep Curl',
                style: getTextStyleWorkSans(
                  color: AppColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Biceps',
                style: getTextStyleWorkSans(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          // Number Picker with Stack
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // NumberPicker - make selected text transparent
                Obx(() => NumberPicker(
                      value: controller.selectedTime.value,
                      minValue: 5,
                      maxValue: 60,
                      step: 5,
                      itemHeight: 40,
                      itemCount: 7, // Show 7 items total (3 before + 1 selected + 3 after)
                      axis: Axis.vertical,
                      textStyle: getTextStyleWorkSans(
                        color: AppColors.textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      selectedTextStyle: getTextStyleWorkSans(
                        color: Colors.transparent, // Make selected text transparent
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      onChanged: (value) => controller.updateTime(value),
                    )),
                
                // Overlay container - only cover the middle section
                Positioned(
                  child: IgnorePointer(
                    child: Obx(
                      () => Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1, // Full width
                        color: AppColors.secondary,
                        alignment: Alignment.center,
                        child: Text(
                          '${controller.selectedTime.value}',
                          style: getTextStyleWorkSans(
                            color: AppColors.textfieldBackground,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Done Button
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: GestureDetector(
              onTap: () {
                onTimeSelected(controller.selectedTime.value);
                Get.back();
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Done',
                  style: getTextStyleWorkSans(
                    color: AppColors.textfieldBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function to show the bottom sheet
void showRestTimerBottomSheet({
  required BuildContext context,
  required Function(int) onTimeSelected,
  int initialTime = 5,
}) {
  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => RestTimerBottomSheet(
      onTimeSelected: onTimeSelected,
      initialTime: initialTime,
    ),
  );
}