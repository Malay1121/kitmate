import 'package:get/get.dart';
import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';

class HomeController extends GetxController {
  Map? recipe;

  void generateRecipe() async {
    Map geminiResult =
        await GeminiHelper.fetch(systemPrompt: AppStrings.dishPrompt, data: {
      "preferences": getStorage.read("preferences"),
      "ingredients": getStorage.read("ingredients"),
    });

    if (geminiResult["context"] == true) {
      recipe = geminiResult["data"];
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    generateRecipe();
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
