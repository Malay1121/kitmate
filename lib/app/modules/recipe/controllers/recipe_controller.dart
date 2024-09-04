import 'package:kitmate/app/helper/all_imports.dart';

class RecipeController extends CommonController {
  Map? recipe;
  List steps = [];
  int currentStep = 0;
  @override
  void onInit() {
    super.onInit();
  }

  void nextStep() {
    if (steps.length <= currentStep + 1) {
      Get.back();
    } else {
      currentStep++;
      update();
    }
  }

  void previousStep() {
    if (0 >= currentStep) {
      Get.back();
    } else {
      currentStep--;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      recipe = Get.arguments;
      steps = recipe!["steps"];
      update();
    } else {
      Get.back();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
