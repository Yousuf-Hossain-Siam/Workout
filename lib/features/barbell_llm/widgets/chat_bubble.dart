import 'package:flutter/material.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/barbell_llm/widgets/feedback_buttons.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final int messageIndex;
  final Function(bool isPositive, String? comment)? onFeedback;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.messageIndex,
    this.onFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.secondary : AppColors.appbar,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft:
                            isUser ? Radius.circular(16) : Radius.circular(0),
                        bottomRight:
                            isUser ? Radius.circular(0) : Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      message,
                      style: getTextStyleWorkSans(
                        color:
                            isUser
                                ? AppColors.textFieldFill
                                : AppColors.textWhite,
                        lineHeight: 12,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (!isUser && onFeedback != null) ...[
            // Only show feedback for AI responses
            const SizedBox(height: 2),
            FeedbackButtons(
              messageIndex: messageIndex,
              onFeedback: onFeedback!,
            ),
          ],
        ],
      ),
    );
  }
}
