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

  void checkIngredientsMaxedOut() {
    if (pro == false) {
      {
        String searchText = "";
        TextEditingController searchController = TextEditingController();
        List<Map<dynamic, dynamic>> selectedIngredients = [];

        for (int i = 0;
            i <
                ingredients.length -
                    getKey(freeLimitations, ["max_ingredients"], 30);
            i++) {
          selectedIngredients.add(ingredients[i]);
        }
        // Ingredients limit check
        if (ingredients.length >
            getKey(freeLimitations, ["max_ingredients"], 30)) {
          Get.dialog(
            PopScope(
              canPop: false,
              child: Dialog(
                insetPadding: EdgeInsets.zero,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return SingleChildScrollView(
                      child: Container(
                        width: 196.w(Get.context!),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 11.w(context),
                          vertical: 11.h(context),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              text: AppStrings.maxIngredientsReached,
                              style: Styles.semiBold(
                                color: AppColors.fontDark,
                                fontSize: 13.t(context),
                              ),
                              maxLines: 2,
                              width: 150.w(context),
                              centered: true,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5.h(context),
                            ),
                            AppRichText(
                              textAlign: TextAlign.center,
                              width: 150.w(context),
                              centered: true,
                              maxLines: 2,
                              text: TextSpan(
                                text: (ingredients.length -
                                        getKey(freeLimitations,
                                            ["max_ingredients"], 30))
                                    .toString(),
                                style: Styles.bold(
                                  color: AppColors.primary,
                                  fontSize: 9.5.t(context),
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        " ${AppStrings.ingredientsNeedsToBeRemoved}",
                                    style: Styles.medium(
                                      color: AppColors.fontGrey,
                                      fontSize: 9.5.t(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h(context),
                            ),
                            Center(
                              child: CommonTextField(
                                hintText: AppStrings.searchIngredients,
                                controller: searchController,
                                onChanged: (p0) {
                                  setState(() {
                                    searchText = p0;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10.h(context),
                            ),
                            SizedBox(
                              height: 250.h(context),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: ingredients
                                    .where(
                                      (p0) => getKey(p0, ["label"], "")
                                          .toString()
                                          .toLowerCase()
                                          .startsWith(searchText.toLowerCase()),
                                    )
                                    .length,
                                itemBuilder: (context, index) {
                                  Map ingredient = ingredients[index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 11.w(context),
                                      vertical: 5.h(context),
                                    ),
                                    margin: EdgeInsets.only(
                                      bottom: 11.h(context),
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.cardColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 174.w(context),
                                    child: Row(
                                      children: [
                                        AppText(
                                          text: ingredient["label"],
                                          maxLines: 2,
                                          width: 109.w(context),
                                          minFontSize:
                                              10.t(context).floorToDouble(),
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.bold(
                                            fontSize: 10.t(context),
                                            color: AppColors.fontDark,
                                          ),
                                        ),
                                        Spacer(),
                                        Checkbox(
                                          value: selectedIngredients
                                              .contains(ingredient),
                                          onChanged: (value) {
                                            setState(() {
                                              if (selectedIngredients
                                                  .contains(ingredient)) {
                                                selectedIngredients
                                                    .remove(ingredient);
                                              } else {
                                                selectedIngredients
                                                    .add(ingredient);
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5.h(context),
                            ),
                            CommonButton(
                              text: AppStrings.upgrade,
                              onTap: () => Get.toNamed(Routes.SUBSCRIPTIONS),
                            ),
                            SizedBox(
                              height: 5.h(context),
                            ),
                            CommonButton(
                              text: AppStrings.removeIngredients,
                              backgroundColor: Colors.transparent,
                              textColor: AppColors.fontDark,
                              onTap: () async {
                                if (selectedIngredients.length >=
                                    ingredients.length -
                                        getKey(freeLimitations,
                                            ["max_ingredients"], 30)) {
                                  EasyLoading.show();
                                  await DatabaseHelper.removeIngredients(
                                    userId: user?.uid ?? "",
                                    ingredients: selectedIngredients,
                                  );
                                  EasyLoading.dismiss();
                                  Get.back();
                                } else {
                                  showSnackbar(
                                      message:
                                          "${ingredients.length - getKey(freeLimitations, [
                                                "max_ingredients"
                                              ], 30)} ${AppStrings.ingredientsNeedsToBeRemoved}");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            barrierDismissible: false,
          );
        }
      }
    }
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
        checkIngredientsMaxedOut();
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
