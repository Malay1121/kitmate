import 'package:get/get.dart';

import '../controllers/shopping_list_controller.dart';

class ShoppingListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShoppingListController>(
      () => ShoppingListController(),
    );
  }
}
