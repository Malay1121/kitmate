import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';

import '../../../widgets/expanded_recipe_popup.dart';

Map? generatedRecipe = null;

class GenerateRecipeController extends CommonController {
  List mealTypes = [
    AppStrings.auto,
    AppStrings.snack,
    AppStrings.breakfast,
    AppStrings.lunch,
    AppStrings.dinner,
    AppStrings.none,
  ];

  List pantryMatch = [
    AppStrings.only,
    AppStrings.mostly,
    AppStrings.none,
  ];

  List timeBound = [
    AppStrings.enable,
    AppStrings.disable,
  ];

  Map settingsData = {
    "dish_name": {
      "label": AppStrings.whatWouldYouLikeToMake,
      "description":
          "If you want the recipe of a specific dish, enter the dish name bellow. Leave it blank to get multiple dish options",
      "child": Container(),
      "enabled": true,
    },
    "meal_type": {
      "label": AppStrings.typeOfMeal,
      "selected": [AppStrings.auto],
      "description":
          "Choose what type of meal you'd like to make, if you haven't specified a dish name\nAuto: Automatically selected a meal type based on the time.",
      "child": Container(),
    },
    "allergy_preferences": {
      "label": AppStrings.allergyPreferences,
      "description":
          "Do you have any allergies? Please select all the food items or ingredients that you are allergic to.",
      "child": Container(),
    },
    "diet_preferences": {
      "label": AppStrings.dietaryPreferences,
      "description":
          "Do you follow any specific diet or want your food of a certain type? Mention all of them bellow.",
      "child": Container(),
    },
    "pantry_match": {
      "label": AppStrings.pantryMatch,
      "selected": AppStrings.only,
      "description":
          "Would you like the recipe to be based on the ingredients you have in your pantry?",
      "child": Container(),
    },
    "time_limit": {
      "label": AppStrings.timeBound,
      "enabled": false,
      "selected": null,
      "description":
          "Wether you are in a hurry or have a good time, you can add a time limit to get recipes that you can make within the time bound.",
      "child": Container(),
    },
    "servings": {
      "label": AppStrings.servings,
      "description":
          "Select the number of people you are making the recipe for, the recipe ideas and ingredients will be suggested accordingly.",
      "child": Container(),
      "pro": true,
    },
    "custom_message": {
      "label": AppStrings.anythingElse,
      "description":
          "Is there anything you want us to know other than the answers given above? Let us know, we will suggest recipes accordingly.",
      "child": Container(),
      "pro": true,
    },
  };
  PreferencesManager allergyManager = PreferencesManager(
      recordLabel: AppStrings.recordIngredients,
      options: [].obs,
      prompt: AppStrings.allergyPrompt);
  PreferencesManager dietManager = PreferencesManager(
      recordLabel: AppStrings.recordDiets,
      options: [].obs,
      prompt: AppStrings.dietPrompt);

  void generateRecipes() async {
    EasyLoading.show();
    Map input = {};
    for (String question in settingsData.keys) {
      Map data = {
        question: getKey(settingsData, [question, "enabled"], true)
            ? settingsData[question]["selected"]
            : null,
      };
      input.addEntries(data.entries);
    }
    print(input);
    if (ingredients.length >= 5) {
      Map geminiResult = await GeminiHelper.fetch(
          systemPrompt: AppStrings.recipeListPrompt,
          data: {
            "preferences": userDetails["preferences"],
            "ingredients": ingredients,
            "settings": input,
            "current_time":
                "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}",
          });
      List recipes = [];

      if (geminiResult["context"] == true) {
        if (getKey(geminiResult, ["recipe_found"], null) != null) {
          recipes = geminiResult["data"];
          for (Map recipe in recipes) {
            String image =
                "https://image.pollinations.ai/prompt/${recipe["recipe_title"].toString().replaceAll(" ", "-")}";
            recipe["recipe_image"] = image;
          }
          generatedRecipes.value = recipes;

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
    generatedRecipe = null;
    update();
  }

  void startCooking(Map recipeData) async {
    EasyLoading.show();
    Map geminiResult = await GeminiHelper.fetch(
        systemPrompt: AppStrings.recipeDetailsPrompt, data: recipeData);
    if (getKey(geminiResult, ["context"], false)) {
      if (getKey(geminiResult, ["data", "recipe_found"], false)) {
        Get.toNamed(Routes.RECIPE,
            arguments: getKey(geminiResult, ["data"], {}));
      } else {
        showSnackbar(message: AppStrings.recipeNotFound);
      }
    }
    EasyLoading.dismiss();
  }

  void saveRecipe(Map recipeData, bool generated) async {
    EasyLoading.show();

    if (!generated) {
      Map geminiResult = await GeminiHelper.fetch(
          systemPrompt: AppStrings.recipeDetailsPrompt, data: recipeData);
      if (getKey(geminiResult, ["context"], false)) {
        if (getKey(geminiResult, ["data", "recipe_found"], false)) {
          String image =
              "https://image.pollinations.ai/prompt/${recipeData["recipe_title"].toString().replaceAll(" ", "-")}";
          recipeData["recipe_image"] = image;
          recipeData = getKey(geminiResult, ["data"], {});
        } else {
          showSnackbar(message: AppStrings.recipeNotFound);
        }
      }
    }

    var result = await DatabaseHelper.saveRecipe(
      userId: user?.uid ?? "",
      recipe: Map<String, dynamic>.from(recipeData),
    );

    if (result != null) {
      showSnackbar(message: AppStrings.recipeSaved);
    }
    EasyLoading.dismiss();
  }

  void expandRecipe(Map recipeData) async {
    EasyLoading.show();
    Map geminiResult = await GeminiHelper.fetch(
        systemPrompt: AppStrings.recipeDetailsPrompt, data: recipeData);
    if (getKey(geminiResult, ["context"], false)) {
      if (getKey(geminiResult, ["data", "recipe_found"], false)) {
        expandedRecipePopup(user, getKey(geminiResult, ["data"], {}));
        update();
      } else {
        showSnackbar(message: AppStrings.recipeNotFound);
      }
    }
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    generatedRecipes.listen(
      (p0) => update(),
    );
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
