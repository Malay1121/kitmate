import 'package:kitmate/app/modules/shopping_list/views/shopping_ingredient_card.dart';
import 'package:kitmate/app/modules/shopping_list/views/shopping_recipe_card.dart';

import '../../../helper/all_imports.dart';
import '../controllers/shopping_list_controller.dart';

class ShoppingListView extends GetView<ShoppingListController> {
  const ShoppingListView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingListController>(
        init: ShoppingListController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h(context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 11.w(context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.black,
                            size: 14.t(context),
                          ),
                        ),
                        AppText(
                          text: AppStrings.smartShoppingList,
                          style: Styles.bold(
                            fontSize: 12.t(context),
                            color: AppColors.fontDark,
                          ),
                        ),
                        SizedBox(
                          width: 14.t(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonButton(
                        text: AppStrings.ingredients,
                        backgroundColor:
                            controller.selectedTab == AppStrings.ingredients
                                ? null
                                : AppColors.cardColor,
                        textColor:
                            controller.selectedTab == AppStrings.ingredients
                                ? null
                                : AppColors.fontDark,
                        onTap: () {
                          if (controller.selectedTab !=
                              AppStrings.ingredients) {
                            controller.selectedTab = AppStrings.ingredients;
                            controller.update();
                          }
                        },
                        width: 90.w(context),
                        height: 28.h(context),
                      ),
                      SizedBox(
                        width: 12.w(context),
                      ),
                      CommonButton(
                        text: AppStrings.recipes,
                        onTap: () {
                          if (controller.selectedTab != AppStrings.recipes) {
                            controller.selectedTab = AppStrings.recipes;
                            controller.update();
                          }
                        },
                        backgroundColor:
                            controller.selectedTab == AppStrings.recipes
                                ? null
                                : AppColors.cardColor,
                        textColor: controller.selectedTab == AppStrings.recipes
                            ? null
                            : AppColors.fontDark,
                        width: 90.w(context),
                        height: 28.h(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h(context),
                  ),
                  if (ingredients.isNotEmpty)
                    SizedBox(
                      height: 5.h(context),
                    ),
                  if (ingredients.isNotEmpty)
                    Center(
                      child: CommonTextField(
                        hintText: controller.selectedTab == AppStrings.recipes
                            ? AppStrings.searchRecipes
                            : AppStrings.searchIngredients,
                        controller: controller.searchController,
                        onChanged: (p0) => controller.onSearch(p0),
                      ),
                    ),
                  if (ingredients.isNotEmpty)
                    SizedBox(
                      height: 10.h(context),
                    ),
                  if (ingredients.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.h(context)),
                      child: Center(
                        child: AppText(
                          text: AppStrings.noIngredientsAddedYet,
                          style: Styles.bold(
                            fontSize: 12.t(context),
                            color: AppColors.fontDark,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 11.w(context),
                        ),
                        child: Column(
                          children: [
                            if (controller.shoppingIngredients.isEmpty)
                              Center(
                                child: AppText(
                                  text: AppStrings
                                      .youDoNotHaveEnoughIngredientsForSuggestion,
                                  maxLines: null,
                                  width: 155.w(context),
                                  textAlign: TextAlign.center,
                                  centered: true,
                                  minFontSize: 10.t(context).floorToDouble(),
                                  style: Styles.bold(
                                    fontSize: 10.t(context),
                                    color: AppColors.fontDark,
                                  ),
                                ),
                              ),
                            if (controller.selectedTab ==
                                AppStrings.ingredients)
                              for (Map ingredient
                                  in controller.shoppingIngredients.where(
                                (p0) => getKey(p0, ["label"], "")
                                    .toString()
                                    .toLowerCase()
                                    .startsWith(
                                        controller.searchText.toLowerCase()),
                              ))
                                ShoppingIngredientCard(
                                    controller: controller,
                                    ingredient: ingredient),
                            if (controller.selectedTab == AppStrings.recipes)
                              for (Map recipe
                                  in controller.shoppingRecipes.where(
                                (p0) => getKey(p0, ["label"], "")
                                    .toString()
                                    .toLowerCase()
                                    .startsWith(
                                        controller.searchText.toLowerCase()),
                              ))
                                ShoppingRecipeCard(
                                    controller: controller, recipe: recipe),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11.h(context),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
