import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/features/barbell_llm/view/ask_barbell_chat_screen.dart';
import 'package:luna_3/features/barbell_llm/view/workout_plan_screen.dart';

class BarbellLLMController extends GetxController {
  // Text Controllers
  final fitnessGoalController = TextEditingController();
  final experienceLevelController = TextEditingController();
  final equipmentController = TextEditingController();
  final messageController = TextEditingController();
  final feedbackController = TextEditingController();

  // Observable States
  final isLoading = false.obs;
  final selectedTab = 'Ask'.obs;
  final chatMessages = <Map<String, dynamic>>[].obs;
  final messageFeedback = <int, Map<String, dynamic>>{}.obs;

  // Demo responses for different fitness queries
  final Map<String, String> demoResponses = {
    'squat':
        'Focus on keeping your chest up, core braced, and knees tracking over toes. Start with body weight squats to master technique.',
    'deadlift':
        'Keep the bar close to your body, maintain a neutral spine, and drive through your heels. Start with light weights to perfect form.',
    'bench press':
        'Maintain a stable base, retract your shoulder blades, and keep your feet planted. Control the weight throughout the movement.',
    'nutrition':
        'Focus on balanced meals with lean proteins, complex carbs, and healthy fats. Stay hydrated and time your meals around workouts.',
    'workout':
        'Structure your workouts with proper warm-up, progressive overload, and adequate rest between sets. Listen to your body.',
  };

  @override
  void onInit() {
    super.onInit();
    // Add welcome message when controller is initialized
    chatMessages.add({
      'text':
          'Hello! I\'m Barbell, your AI fitness assistant. How can I help you today?',
      'isUser': false,
      'index': 0,
    });
  }

  @override
  void onClose() {
    fitnessGoalController.dispose();
    experienceLevelController.dispose();
    equipmentController.dispose();
    messageController.dispose();
    feedbackController.dispose();
    super.onClose();
  }

  // Navigation Methods
  void onAskBarbellTap() {
    Get.to(() => const AskBarbellChatScreen());
  }

  void onWorkoutPlanTap() {
    Get.to(() => const WorkoutPlanScreen());
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final userMessage = messageController.text.trim();

    // Add user message
    chatMessages.add({
      'text': userMessage,
      'isUser': true,
      'index': chatMessages.length,
    });

    // Clear input
    messageController.clear();

    // Simulate AI response with delay
    Future.delayed(const Duration(seconds: 1), () {
      String response = _generateResponse(userMessage.toLowerCase());

      chatMessages.add({
        'text': response,
        'isUser': false,
        'index': chatMessages.length,
      });
    });
  }

  void handleFeedback(int messageIndex, bool isPositive, String? comment) {
    messageFeedback[messageIndex] = {
      'isPositive': isPositive,
      'comment': comment,
      'timestamp': DateTime.now().toIso8601String(),
    };
    
    // Here you can implement API calls to send feedback to your backend
    print('Feedback received for message $messageIndex: ${messageFeedback[messageIndex]}');
  }

  String _generateResponse(String query) {
    // Check for specific keywords in the query
    for (var keyword in demoResponses.keys) {
      if (query.contains(keyword)) {
        return demoResponses[keyword]!;
      }
    }

    // Default response if no keyword matches
    return 'I can help you with exercise form, nutrition advice, and workout planning. Could you be more specific about what you\'d like to know?';
  }

  // Form Submission
  void generatePlan() {
    if (_validateForm()) {
      isLoading.value = true;
      Get.to(() => const WorkoutPlanScreen());
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    return fitnessGoalController.text.isNotEmpty &&
        experienceLevelController.text.isNotEmpty &&
        equipmentController.text.isNotEmpty;
  }
}
