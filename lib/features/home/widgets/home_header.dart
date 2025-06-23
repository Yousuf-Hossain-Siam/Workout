import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/icon_path.dart';
import 'package:luna_3/features/profile/controller/profile_controller.dart';

class HomeHeader extends StatelessWidget {
  final String image;
  final VoidCallback? notificationTap;
  const HomeHeader({super.key, required this.image, this.notificationTap});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child:
                  profileController.profileModel?.img != null
                      ? Image.network(
                        profileController.profileModel!.img!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                      : Image.asset(image, width: 40, height: 40),
            ),
            const SizedBox(width: 10),
            Text(
              'Hello, ${profileController.profileModel?.name}',
              style: getTextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                lineHeight: 21,
              ),
            ),
          ],
        ),

        // Notification Icon
        GestureDetector(
          onTap: notificationTap,
          child: Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xff303502)),
              color: const Color(0xff1F2301),
            ),
            child: Image.asset(
              IconPath.notificationicon,
              width: 18,
              height: 18,
            ),
          ),
        ),
      ],
    );
  }
}
