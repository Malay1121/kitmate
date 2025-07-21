import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';

class ShoppingListController extends CommonController {
  TextEditingController searchController = TextEditingController();
  String selectedTab = AppStrings.ingredients;
  List tabs = [AppStrings.ingredients, AppStrings.recipes];

  List shoppingIngredients = [];
  List shoppingRecipes = [];
  @override
  void onInit() {
    super.onInit();
    getShoppingList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String searchText = "";

  void onSearch(String text) {
    searchText = text;
    update();
  }

  void getShoppingList() async {
    EasyLoading.show();
    Map result = await GeminiHelper.fetch(
        systemPrompt: AppStrings.smartShoppingListPrompt,
        data: {"ingredients": ingredients});
    if (getKey(result, ["context"], false)) {
      shoppingIngredients = [];
      shoppingRecipes = [];
      for (Map recipe in getKey(result, ["data"], [])) {
        shoppingRecipes.add(recipe);
        for (Map ingredient in getKey(recipe, ["ingredients"], {})) {
          if (shoppingIngredients.firstWhereOrNull(
                (element) => element["id"] == ingredient["id"],
              ) ==
              null) {
            ingredient.addEntries({
              "recipes": [recipe]
            }.entries);
            shoppingIngredients.add(ingredient);
          } else {
            int index = shoppingIngredients
                .indexWhere((element) => element["id"] == ingredient["id"]);
            shoppingIngredients[index]["quantity"] += ingredient["quantity"];
            shoppingIngredients[index]["recipes"].add(recipe);
          }
        }
      }
      update();
    }
    EasyLoading.dismiss();
  }
}
