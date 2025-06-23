import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';
import 'package:luna_3/features/notification/controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController notificationController = Get.put(
    NotificationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(right: 0, bottom: 3, left: 30),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(IconPath.back, height: 24, width: 24),
          ),
        ),
        backgroundColor: AppColors.background,
        title: Text(
          'Notifications',
          style: getTextStyle1(
            color: AppColors.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.05),
                shape: BoxShape.circle,
                border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.10)),
              ),
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Image.asset(IconPath.notification2),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: ListView.builder(
            itemCount: notificationController.items.length,
            itemBuilder: (context, index) => SwipeTile(index: index),
          ),
        ),
      ),
    );
  }
}

class SwipeTile extends StatelessWidget {
  final int index;
  final NotificationController controller = Get.find();
  SwipeTile({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        double currentOffset =
            controller.swipeOffsets[index] + details.delta.dx;
        if (currentOffset <= 0 && currentOffset >= -37) {
          controller.updateOffset(index, currentOffset);
        }
      },
      onHorizontalDragEnd: (details) {
        double offset = controller.swipeOffsets[index];
        if (offset < -20) {
          controller.revealDelete(index);
        } else {
          controller.resetOffset(index);
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Obx(() {
              return AnimatedOpacity(
                opacity: controller.swipeOffsets[index] <= -37 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      color: Color(0xFFF97316),
                    ),
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 7),
                      child: GestureDetector(
                        onTap: () {
                          controller.items.removeAt(index);
                          controller.swipeOffsets.removeAt(index);
                        },
                        child: Image.asset(
                          IconPath.removed,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          Obx(() {
            return Transform.translate(
              offset: Offset(controller.swipeOffsets[index], 0),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF1C2227),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            controller.items[index]['time']!,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFF97316),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              controller.items[index]['title']!,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              controller.items[index]['subtitle']!,
                              style: GoogleFonts.inter(
                                color: Color(0xFF8C8C8C),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
