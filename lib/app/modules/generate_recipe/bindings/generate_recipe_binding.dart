import 'package:get/get.dart';

import '../controllers/generate_recipe_controller.dart';

class GenerateRecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateRecipeController>(
      () => GenerateRecipeController(),
    );
  }
}
