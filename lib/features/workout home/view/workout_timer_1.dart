import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/core/utils/constants/api_constants.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';
import 'package:luna_3/features/progress/controllers/progress_controller.dart';
import 'package:luna_3/features/progress/widgets/stats_cards_row.dart';
import 'package:luna_3/features/workout%20home/controller/all_workout_controller.dart';
import 'package:luna_3/features/workout%20home/controller/workout_timer_controller_api.dart';
import 'package:luna_3/features/workout%20home/model/workout_timer_model.dart';
import 'package:luna_3/features/workout%20home/view/add_exercise_screen.dart';
import 'package:luna_3/features/workout%20home/widgets/rest_timer_bottomsheet.dart';
// Import your existing controller
import 'package:slide_countdown/slide_countdown.dart';

// Your WorkoutController class (no changes needed here for this specific fix)
class WorkoutController extends GetxController {
  static WorkoutController get to => Get.find();

  var sets = <Map<String, dynamic>>[].obs;
  var restTime = 60.obs;
  var activeStartIndices = <int>{}.obs;
  var isTimerRunning = false.obs;
  var workoutCompleted = false.obs;

  void addSet() {
    sets.add({
      'SET': (sets.length + 1).toString(),
      'KG': '0',
      'REPS': '0',
      'STARTED': false,
    });
  }

  void updateSetValue(int index, String field, String value) {
    if (index >= 0 && index < sets.length) {
      var set = sets[index];
      set[field] = value;
      sets[index] = Map<String, dynamic>.from(set);
      sets.refresh(); // Use sets.refresh() to ensure Obx reacts to changes in individual map items
    }
  }

  void toggleStart(int index) {
    if (activeStartIndices.contains(index)) {
      activeStartIndices.remove(index);
    } else {
      activeStartIndices.add(index);
    }
    isTimerRunning.value = activeStartIndices.isNotEmpty;
  }

  bool isStarted(int index) => activeStartIndices.contains(index);
}

class WorkoutTimer1 extends StatelessWidget {
  const WorkoutTimer1({super.key, required this.index});
    final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WorkoutController());
    final allWorkoutController = Get.put(AllWorkoutController());
    final progressController = Get.put(ProgressController());
    final workoutTimerCtrl = Get.put(workoutTimerController()); // Use your existing controller
    
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: 'All Exercise',
                showBackButton: true,
                showNotification: true,
                onBackPressed: () {
                  Get.back();
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.appbar,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            allWorkoutController.workoutList[index].img ?? '',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allWorkoutController.workoutList[index].name ?? '',
                              style: getTextStyleWorkSans(
                                color: AppColors.textWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              allWorkoutController.workoutList[index].exerciseType ?? '',
                              style: getTextStyleWorkSans(
                                color: AppColors.textWhite,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      style: getTextStyleWorkSans(
                        color: AppColors.textWhite,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Add Note Here......',
                        hintStyle: getTextStyleWorkSans(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        showRestTimerBottomSheet(
                          context: context,
                          initialTime: controller.restTime.value,
                          onTimeSelected: (selectedTime) {
                            controller.restTime.value = selectedTime;
                          },
                        );
                      },
                      child: Obx(
                        () => Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Reset Time: ',
                              style: getTextStyleWorkSans(
                                color: AppColors.textWhite,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            // Directly use controller.isTimerRunning.value and controller.restTime.value here
                            controller.isTimerRunning.value
                                ? SlideCountdown(
                                  key: ValueKey(controller.restTime.value),
                                  duration: Duration(
                                    seconds: controller.restTime.value,
                                  ),
                                  separator: ":",
                                  style: getTextStyleWorkSans(
                                    color: AppColors.textWhite,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  padding: EdgeInsets.zero,
                                  decoration: const BoxDecoration(),
                                  onDone: () {
                                    controller.isTimerRunning.value = false;
                                    controller.workoutCompleted.value = true;
                                  },
                                )
                                : Text(
                                  '${controller.restTime.value}s',
                                  style: getTextStyleWorkSans(
                                    color: AppColors.textWhite,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      // Wrap the whole row with Obx to react to changes in 'sets'
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            ['SET', 'KG', 'REPS', 'START'].map((column) {
                              return Container(
                                // height: MediaQuery.of(context).size.height / 9,
                                width: MediaQuery.of(context).size.height / 12,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0x1A17B9FF),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          column,
                                          style: getTextStyle1(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: AppColors.textWhite,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ...List.generate(controller.sets.length, (
                                          index,
                                        ) {
                                          final set = controller.sets[index];
                                          if (column == 'SET') {
                                            return SizedBox(
                                              height:
                                                  28, // Match the height of KG and REPS columns
                                              child: Center(
                                                // Center the text vertically
                                                child: Text(
                                                  set['SET'],
                                                  style: getTextStyle1(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: AppColors.textWhite,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (column == 'KG') {
                                            return SizedBox(
                                              height: 28,
                                              child: TextField(
                                                controller: TextEditingController(
                                                    text: set['KG'],
                                                  )
                                                  ..selection =
                                                      TextSelection.collapsed(
                                                        offset:
                                                            set['KG'].length,
                                                      ),
                                                keyboardType:
                                                    TextInputType.number,
                                                style: getTextStyle1(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AppColors.textWhite,
                                                ),
                                                textAlign: TextAlign.center,
                                                decoration:
                                                    const InputDecoration(
                                                      border: InputBorder.none,
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 4,
                                                            vertical: 10,
                                                          ),
                                                    ),
                                                onChanged: (value) {
                                                  controller.updateSetValue(
                                                    index,
                                                    'KG',
                                                    value,
                                                  );
                                                },
                                              ),
                                            );
                                          } else if (column == 'REPS') {
                                            return SizedBox(
                                              height: 28,
                                              child: TextField(
                                                controller: TextEditingController(
                                                    text: set['REPS'],
                                                  )
                                                  ..selection =
                                                      TextSelection.collapsed(
                                                        offset:
                                                            set['REPS'].length,
                                                      ),
                                                keyboardType:
                                                    TextInputType.number,
                                                style: getTextStyle1(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AppColors.textWhite,
                                                ),
                                                textAlign: TextAlign.center,
                                                decoration:
                                                    const InputDecoration(
                                                      border: InputBorder.none,
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 4,
                                                            vertical: 10,
                                                          ),
                                                    ),
                                                onChanged: (value) {
                                                  controller.updateSetValue(
                                                    index,
                                                    'REPS',
                                                    value,
                                                  );
                                                },
                                              ),
                                            );
                                          } else if (column == 'START') {
                                            final isStarted = controller
                                                .isStarted(index);
                                            return SizedBox(
                                              height: 28,

                                              child: Center(
                                                child: GestureDetector(
                                                  onTap:
                                                      () => controller
                                                          .toggleStart(index),
                                                  child: Image.asset(
                                                    isStarted
                                                        ? IconPath.starttickicon
                                                        : IconPath
                                                            .starttickicon,
                                                    height: 15,
                                                    width: 15,
                                                    color:
                                                        isStarted
                                                            ? Colors.yellow
                                                            : null,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const SizedBox.shrink();
                                          }
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        controller.addSet();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 21),
                        alignment: Alignment.center,
                        child: Text(
                          'Add Set',
                          style: getTextStyleWorkSans(
                            color: AppColors.textfieldBackground,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(AddExerciseScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Add Exercise',
                      style: getTextStyleWorkSans(
                        color: AppColors.textfieldBackground,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Show stats cards always, before the chart
              StatsCardsRow(controller: progressController),
              const SizedBox(height: 30),
              WorkoutProgressChart(controller: progressController),
              const SizedBox(height: 24),
              // Stats Cards and Weekly Progress Section only shown when workout is completed
              Obx(
                () =>
                    controller.workoutCompleted.value
                        ? Column(children: [const SizedBox(height: 20)])
                        : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutProgressChart extends StatefulWidget {
  final ProgressController controller;
  const WorkoutProgressChart({super.key, required this.controller});

  @override
  State<WorkoutProgressChart> createState() => _WorkoutProgressChartState();
}

class _WorkoutProgressChartState extends State<WorkoutProgressChart> {
  int selectedIndex = 0; // 0: Duration, 1: Volume, 2: Reps
  final List<String> tabs = ['DURATION', 'VOLUME', 'REPS'];
  String selectedView = 'WEEKLY VIEW';
  final List<String> viewOptions = [
    'WEEKLY VIEW',
    'MONTHLY VIEW',
    'YEARLY VIEW',
  ];

  List<Map<String, dynamic>> get chartData {
    // Replace with your real data logic
    if (selectedView == 'WEEKLY VIEW') {
      if (selectedIndex == 0) {
        // Duration (hours)
        return [
          {'day': 'MON', 'value': 1.0},
          {'day': 'TUE', 'value': 0.8},
          {'day': 'WED', 'value': 0.6},
          {'day': 'THU', 'value': 0.7},
          {'day': 'FRI', 'value': 0.9},
          {'day': 'SAT', 'value': 0.5},
        ];
      } else if (selectedIndex == 1) {
        // Volume (kg)
        return [
          {'day': 'MON', 'value': 120},
          {'day': 'TUE', 'value': 150},
          {'day': 'WED', 'value': 100},
          {'day': 'THU', 'value': 130},
          {'day': 'FRI', 'value': 170},
          {'day': 'SAT', 'value': 90},
        ];
      } else {
        // Reps
        return [
          {'day': 'MON', 'value': 60},
          {'day': 'TUE', 'value': 80},
          {'day': 'WED', 'value': 50},
          {'day': 'THU', 'value': 70},
          {'day': 'FRI', 'value': 90},
          {'day': 'SAT', 'value': 40},
        ];
      }
    } else if (selectedView == 'MONTHLY VIEW') {
      if (selectedIndex == 0) {
        // Duration (hours) for each week
        return [
          {'day': 'WK1', 'value': 5.0},
          {'day': 'WK2', 'value': 6.2},
          {'day': 'WK3', 'value': 4.8},
          {'day': 'WK4', 'value': 7.1},
        ];
      } else if (selectedIndex == 1) {
        // Volume (kg) for each week
        return [
          {'day': 'WK1', 'value': 700},
          {'day': 'WK2', 'value': 800},
          {'day': 'WK3', 'value': 650},
          {'day': 'WK4', 'value': 900},
        ];
      } else {
        // Reps for each week
        return [
          {'day': 'WK1', 'value': 320},
          {'day': 'WK2', 'value': 400},
          {'day': 'WK3', 'value': 350},
          {'day': 'WK4', 'value': 420},
        ];
      }
    } else {
      // YEARLY VIEW
      if (selectedIndex == 0) {
        // Duration (hours) for each month
        return [
          {'day': 'JAN', 'value': 22.0},
          {'day': 'FEB', 'value': 18.5},
          {'day': 'MAR', 'value': 25.0},
          {'day': 'APR', 'value': 20.0},
          {'day': 'MAY', 'value': 24.0},
          {'day': 'JUN', 'value': 19.0},
          {'day': 'JUL', 'value': 23.0},
          {'day': 'AUG', 'value': 21.0},
          {'day': 'SEP', 'value': 20.0},
          {'day': 'OCT', 'value': 22.0},
          {'day': 'NOV', 'value': 18.0},
          {'day': 'DEC', 'value': 26.0},
        ];
      } else if (selectedIndex == 1) {
        // Volume (kg) for each month
        return [
          {'day': 'JAN', 'value': 3200},
          {'day': 'FEB', 'value': 2800},
          {'day': 'MAR', 'value': 3500},
          {'day': 'APR', 'value': 3000},
          {'day': 'MAY', 'value': 3400},
          {'day': 'JUN', 'value': 2900},
          {'day': 'JUL', 'value': 3300},
          {'day': 'AUG', 'value': 3100},
          {'day': 'SEP', 'value': 3000},
          {'day': 'OCT', 'value': 3200},
          {'day': 'NOV', 'value': 2700},
          {'day': 'DEC', 'value': 3600},
        ];
      } else {
        // Reps for each month
        return [
          {'day': 'JAN', 'value': 1600},
          {'day': 'FEB', 'value': 1400},
          {'day': 'MAR', 'value': 1750},
          {'day': 'APR', 'value': 1500},
          {'day': 'MAY', 'value': 1700},
          {'day': 'JUN', 'value': 1450},
          {'day': 'JUL', 'value': 1650},
          {'day': 'AUG', 'value': 1550},
          {'day': 'SEP', 'value': 1500},
          {'day': 'OCT', 'value': 1600},
          {'day': 'NOV', 'value': 1350},
          {'day': 'DEC', 'value': 1800},
        ];
      }
    }
  }

  double get maxValue {
    if (chartData.isEmpty) return 1;
    return chartData
        .map((e) => e['value'] as num)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
  }

  String get chartTitle {
    switch (selectedIndex) {
      case 0:
        if (selectedView == 'WEEKLY VIEW') return '01 HOURS';
        if (selectedView == 'MONTHLY VIEW') return 'HOURS';
        if (selectedView == 'YEARLY VIEW') return 'HOURS';
        return 'HOURS';
      case 1:
        return 'VOLUME';
      case 2:
        return 'REPS';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff2A2F37),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                chartTitle,
                style: getTextStyleWorkSans(
                  color: AppColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  DropdownButton<String>(
                    value: selectedView,
                    dropdownColor: const Color(0xff2A2F37),
                    style: getTextStyleWorkSans(
                      color: const Color(0xffA2A6AB),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xffA2A6AB),
                    ),
                    items:
                        viewOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedView = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxValue * 1.2,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int idx = value.toInt();
                        if (idx < 0 || idx >= chartData.length)
                          return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            chartData[idx]['day'],
                            style: getTextStyleWorkSans(
                              color: const Color(0xffA2A6AB),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      reservedSize: 32,
                    ),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(chartData.length, (i) {
                  final value = chartData[i]['value'] as num;
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: value.toDouble(),
                        color: AppColors.secondary,
                        width: 18,
                        borderRadius: BorderRadius.circular(6),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxValue * 1.2,
                          color: const Color(0xff434B53),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: List.generate(tabs.length, (i) {
                final isSelected = selectedIndex == i;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedIndex = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.background
                                : Colors.transparent,
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.secondary
                                  : AppColors.textWhite.withOpacity(0.2),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tabs[i],
                        style: getTextStyleWorkSans(
                          color:
                              isSelected
                                  ? AppColors.secondary
                                  : AppColors.textWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}