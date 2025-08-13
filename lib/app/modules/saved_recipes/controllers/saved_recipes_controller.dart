import 'package:kitmate/app/helper/all_imports.dart';

class SavedRecipesController extends CommonController {
  Map? recipe;

  void deleteRecipe(String recipeId) async {
    EasyLoading.show();
    var result = await DatabaseHelper.deleteRecipe(
      userId: user?.uid ?? "",
      recipeId: recipeId,
    );

    if (result != null) {
      showSnackbar(message: "Recipe deleted successfully");
      update();
    }
    EasyLoading.dismiss();
  }

  void startCooking(Map recipeData) async {
    Get.toNamed(Routes.RECIPE, arguments: recipeData);
  }

  void expandRecipe(Map recipeData) async {
    recipe = recipeData;
    update();
  }

  void closeRecipe() {
    recipe = null;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
