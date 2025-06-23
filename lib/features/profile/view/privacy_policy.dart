import 'package:flutter/material.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';

import '../widget/custom_text.dart' show CustomTitleText;
import '../widget/custom_text_style.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      appBar: AppBarWidget(
        title: 'Privacy Policy',
        showNotification: true,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitleText(text: 'Introduction :', fontSize: 20),
              SizedBox(height: 10),
              CustomTitleText(
                text:
                    'Workout respects your privacy and is committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use the Workout app.',
              ),
              SizedBox(height: 18),
              CustomTitleText(
                text:
                    'How We Use Your Information We collect and use your data to:',
              ),
              SizedBox(height: 10),
              CustomText(text: 'Track and display your workouts'),
              CustomText(
                text: 'Provide progress reports and performance trends',
              ),
              CustomText(text: 'Improve app performance and features'),
              CustomText(
                text:
                    'Send workout reminders, tips, and updates (if you opt-in)',
              ),
              SizedBox(height: 10),
              CustomTitleText(
                text:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
