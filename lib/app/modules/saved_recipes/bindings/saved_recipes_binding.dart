import 'package:get/get.dart';

import '../controllers/saved_recipes_controller.dart';

class SavedRecipesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedRecipesController>(
      () => SavedRecipesController(),
    );
  }
}
