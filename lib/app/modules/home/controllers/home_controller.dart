import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';
import 'package:kitmate/app/modules/home/views/settings_view.dart';

class HomeController extends CommonController {
  Map? recipe;
  List<dynamic>? recipes;
  List<dynamic> savedRecipes = [];
  Map settings = {
    "consider_current_time": true,
    "consider_allergies": true,
    "consider_diet": true,
    "allow_flexibility": false,
    "time_limit": "",
    "custom_message": "",
    "servings": "",
  };

  SpeechToIngredients speechToIngredients = SpeechToIngredients();

  void generateRecipes() async {
    EasyLoading.show();
    print({
      "preferences": userDetails["preferences"],
      "ingredients": ingredients,
      "settings": settings,
      "current_time":
          "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}",
    });
    if (ingredients.length >= 5) {
      Map geminiResult = await GeminiHelper.fetch(
          systemPrompt: AppStrings.recipeListPrompt,
          data: {
            "preferences": userDetails["preferences"],
            "ingredients": ingredients,
            "settings": settings,
            "current_time":
                "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}",
          });

      if (geminiResult["context"] == true) {
        if (getKey(geminiResult, ["recipe_found"], null) != null) {
          recipes = geminiResult["data"];
          for (Map recipe in recipes ?? []) {
            String image =
                "https://image.pollinations.ai/prompt/${recipe["recipe_title"].toString().replaceAll(" ", "-")}";
            recipe["recipe_image"] = image;
          }

          // String image = await getImage(recipe!["recipe_title"]);
          update();
        } else {
          showSnackbar(
            message: "${AppStrings.recipeNotFound}\n\n" +
                getKey(geminiResult, ["recipe_reason"], ""),
          );
        }
      }
    } else {
      showSnackbar(message: AppStrings.ingredientNumberValidation);
    }
    EasyLoading.dismiss();
  }

  void closeRecipe() {
    recipe = null;
    update();
  }

  void startCooking(Map recipeData) async {
    Get.toNamed(Routes.RECIPE, arguments: recipeData);
  }

  void saveRecipe(Map recipeData) async {
    EasyLoading.show();

    // Check if recipe is already saved
    var existingRecipe = savedRecipes.firstWhereOrNull((recipe) =>
        getKey(recipe, ["recipe_title"], "") ==
        getKey(recipeData, ["recipe_title"], ""));

    if (existingRecipe != null) {
      showSnackbar(message: AppStrings.recipeAlreadySaved);
      EasyLoading.dismiss();
      return;
    }

    var result = await DatabaseHelper.saveRecipe(
      userId: user?.uid ?? "",
      recipe: Map<String, dynamic>.from(recipeData),
    );

    if (result != null) {
      showSnackbar(message: AppStrings.recipeSaved);
      loadSavedRecipes(); // Refresh the saved recipes list
    }
    EasyLoading.dismiss();
  }

  void loadSavedRecipes() {
    // This will be handled by FirestorePagination in the view
    // But we keep a local list for quick access/checking
    update();
  }

  void deleteRecipe(String recipeId) async {
    EasyLoading.show();
    var result = await DatabaseHelper.deleteRecipe(
      userId: user?.uid ?? "",
      recipeId: recipeId,
    );

    if (result != null) {
      savedRecipes
          .removeWhere((recipe) => getKey(recipe, ["id"], "") == recipeId);
      showSnackbar(message: "Recipe deleted successfully");
      update();
    }
    EasyLoading.dismiss();
  }

  String getRelativeTime(int timestamp) {
    final now = DateTime.now();
    final savedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final difference = now.difference(savedTime);

    if (difference.inDays == 0) {
      return AppStrings.today;
    } else if (difference.inDays == 1) {
      return AppStrings.yesterday;
    } else {
      return "${difference.inDays} ${AppStrings.daysAgo}";
    }
  }

  void settingsPopup(HomeController controller) {
    showDialog(
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              width: 196.w(Get.context!),
              height: 320.h(Get.context!),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 11.w(Get.context!),
                ),
                child: SizedBox(
                  height: 260.h(Get.context!),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14.5.h(Get.context!),
                      ),
                      AppText(
                        text: AppStrings.settings,
                        maxLines: null,
                        centered: true,
                        textAlign: TextAlign.center,
                        width: 160.w(Get.context!),
                        height: 20.h(context),
                        style: Styles.semiBold(
                          fontSize: 14.55.t(Get.context!),
                          color: AppColors.fontDark,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 11.w(Get.context!),
                        ),
                        child: SizedBox(
                          height: 275.5.h(context),
                          child: SettingsView(
                            controller: controller,
                            customMessage:
                                getKey(settings, ["custom_message"], ""),
                            servings: getKey(settings, ["servings"], ""),
                            popup: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h(Get.context!),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
      context: Get.context!,
    );
  }

  @override
  void onInit() {
    super.onInit();
    loadSavedRecipes();

    userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .snapshots()
        .listen(
      (event) {
        userDetails = event.data() ?? {};
        print("userDetails: $userDetails");
        update();
      },
    );
    ingredientsStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("ingredients")
        .snapshots()
        .listen(
      (event) {
        for (DocumentChange change in event.docChanges) {
          if (change.type == DocumentChangeType.added) {
            ingredients.add(change.doc.data());
            continue;
          }
          if (change.type == DocumentChangeType.modified) {
            int index = ingredients.indexWhere(
              (element) =>
                  getKey(element, ["label"], "existing") ==
                  getKey(change.doc.data() as Map, ["label"], "change"),
            );
            ingredients[index] = change.doc.data();
            continue;
          }
          if (change.type == DocumentChangeType.removed) {
            ingredients.removeWhere(
              (element) =>
                  getKey(element, ["label"], "existing") ==
                  getKey(change.doc.data() as Map, ["label"], "change"),
            );
            continue;
          }
        }
        update();
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      if (getKey(Get.arguments, ["first_time"], false)) {
        Get.toNamed(Routes.INGREDIENTS);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
