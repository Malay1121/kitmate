import 'package:get/get.dart';

import '../controllers/ingredients_controller.dart';

class IngredientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IngredientsController>(
      () => IngredientsController(),
    );
  }
}
