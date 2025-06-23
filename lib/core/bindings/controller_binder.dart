import 'package:get/get.dart';
import 'package:luna_3/core/common/controllers/custom_bottom_nav_bar_controller.dart';
import 'package:luna_3/core/common/widgets/custom_text_form_field.dart';
import 'package:luna_3/core/services/network_caller.dart';
import 'package:luna_3/features/auth/controller/create_account_controller.dart';
import 'package:luna_3/features/auth/controller/login_controller.dart';
import 'package:luna_3/features/food_logging/controllers/add_consumed_food_controller.dart';
import 'package:luna_3/features/food_logging/controllers/add_food_manually_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_calories_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_image_controller.dart';
import 'package:luna_3/features/food_logging/controllers/food_logging_controller.dart';
import 'package:luna_3/features/food_logging/controllers/logged_food_controller.dart';
import 'package:luna_3/features/profile/controller/profile_controller.dart';
import 'package:luna_3/features/tips_tab/controllers/article_controller.dart';
import 'package:luna_3/features/workout%20setup/controller/get_workout_setup_controller.dart';
import 'package:luna_3/features/workout%20setup/controller/top_progress_controller.dart';
import 'package:luna_3/features/workout%20setup/controller/workout_setup_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkCaller());

    // common controllers
    Get.put(ObscureController());
    // Tips Tab

    // auth controllers
    Get.put(CreateAccountController());

    // workout setup
    Get.put(WorkoutSetupController());
    Get.put(GetWorkoutSetupController());
    Get.put(TopProgressController());

    // profile
    Get.put(ProfileController());

    // tips tab

    Get.put(LoginController());
    Get.put(CustomBottomNavBarController());
    Get.put(ArticleController());

    // food logging
    Get.put(FoodImageController());
    Get.put(FoodLoggingController());
    Get.put(LoggedFoodController());
    Get.put(FoodCaloriesController());
    Get.put(AddConsumedFoodController());
    Get.put(AddFoodManuallyController());
  }
}
