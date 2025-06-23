import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';
import 'package:luna_3/features/barbell_llm/controllers/barbell_llm_controller.dart';
import 'package:luna_3/features/barbell_llm/widgets/chat_bubble.dart';

class AskBarbellChatScreen extends StatelessWidget {
  const AskBarbellChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarbellLLMController());

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomAppBar(
                title: 'Ask Barbell',
                showNotification: true,
                showBackButton: true,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.border, width: 0.4),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      Text(
                        'Ask Barbell',
                        textAlign: TextAlign.center,
                        style: getTextStyleWorkSans(
                          color: AppColors.textWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SvgPicture.asset(SvgPath.divider),
                      const SizedBox(height: 8),

                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 15,
                            ),
                            itemCount: controller.chatMessages.length,
                            itemBuilder: (context, index) {
                              final message = controller.chatMessages[index];
                              final messageIndex = message['index'] ?? index;
                              return ChatBubble(
                                message: message['text'],
                                isUser: message['isUser'],
                                messageIndex: messageIndex,
                                onFeedback: !message['isUser']
                                    ? (isPositive, comment) => controller.handleFeedback(
                                        messageIndex, isPositive, comment)
                                    : null,
                              );
                            },
                          ),
                        ),
                      ),
                      _buildMessageInput(controller),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(BarbellLLMController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.messageController,
            style: getTextStyleWorkSans(
              color: AppColors.textWhite,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              suffixIcon: GestureDetector(
                onTap: controller.sendMessage,
                child: SvgPicture.asset(SvgPath.sendSvg),
              ),
              fillColor: AppColors.background,
              hintText: 'Ask Barbell',
              hintStyle: getTextStyleWorkSans(
                color: AppColors.textWhite,
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 0.4),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border, width: 0.4),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onSubmitted: (_) => controller.sendMessage(),
          ),
        ),
      ],
    );
  }
}
