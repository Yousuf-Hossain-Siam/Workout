import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/sizer.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';
import 'package:luna_3/features/notification/screen/notification_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.centerTitle = false,
    this.showBackButton = true,
    this.title = '',
    this.showNotification = false,
    this.actions,
    this.onClickBackButton,
  });

  final bool showBackButton;
  final void Function()? onClickBackButton;
  final bool centerTitle;
  final String title;
  final bool showNotification;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: Sizer.wp(20),
      title: Row(
        spacing: 10,
        children: [
          if (showBackButton)
            IconButton(
              onPressed:
                  onClickBackButton ??
                  () {
                    Get.back();
                  },
              icon: SvgPicture.asset(
                SvgPath.backArrowSvg,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.textTitle,
                  BlendMode.srcIn,
                ),
              ),
            ),
          Text(
            title,
            style: getTextStyleWorkSans(
              fontSize: 18,
              color: AppColors.textTitle,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),

      actions: [
        if (actions != null) ...actions!,
        if (showNotification)
          IconButton(
            onPressed: () {
              Get.to(() => NotificationScreen());
            },
            icon: Container(
              width: 34.28,
              height: 34.28,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.notificationBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.notificationBorder),
              ),
              child: SvgPicture.asset(
                SvgPath.notificationBell,
                // width: 48,
                // height: 48,
                // color: Color(0xffF97316),
              ),
            ),
          ),
        SizedBox(width: Sizer.wp(16)),
      ],
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
