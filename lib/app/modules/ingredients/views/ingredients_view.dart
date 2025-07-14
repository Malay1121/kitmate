import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/ingredients_controller.dart';

class IngredientsView extends GetView<IngredientsController> {
  const IngredientsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IngredientsController>(
      init: IngredientsController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35.5.h(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w(context),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print(userDetails);
                    },
                    child: AppText(
                      text: AppStrings.ingredientsInStock,
                      maxLines: 2,
                      width: 160.w(context),
                      style: Styles.semiBold(
                        fontSize: 15.55.t(context),
                        color: AppColors.fontDark,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w(context),
                  ),
                  child: AppText(
                    text: AppStrings.longPressAnIngredientToRemoveIt,
                    maxLines: 1,
                    width: 160.w(context),
                    style: Styles.regular(
                      fontSize: 8.55.t(context),
                      color: AppColors.fontDark,
                    ),
                  ),
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
                      hintText: AppStrings.searchIngredients,
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
                          for (Map ingredient in ingredients.where(
                            (p0) => getKey(p0, ["label"], "")
                                .toString()
                                .toLowerCase()
                                .startsWith(
                                    controller.searchText.toLowerCase()),
                          ))
                            GestureDetector(
                              onLongPress: () =>
                                  controller.removeIngredient(ingredient),
                              onTap: () => controller.addIngredient(
                                edit: true,
                                ingredient: ingredient,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 11.w(context),
                                  vertical: 11.h(context),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 11.h(context),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: 196.w(context),
                                child: Row(
                                  children: [
                                    AppText(
                                      text: ingredient["label"],
                                      minFontSize:
                                          10.t(context).floorToDouble(),
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.bold(
                                        fontSize: 10.t(context),
                                        color: AppColors.fontDark,
                                      ),
                                    ),
                                    Spacer(),
                                    AppText(
                                      text:
                                          "${ingredient["quantity"]} ${ingredient["quantity_unit"]}",
                                      style: Styles.bold(
                                        fontSize: 7.t(context),
                                        color: AppColors.fontDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 11.w(context),
                            ),
                            child: AppText(
                              text: AppStrings.ingredientBySpeechExample,
                              centered: true,
                              textAlign: TextAlign.center,
                              maxLines: null,
                              style: Styles.regular(
                                fontSize: 8.55.t(context),
                                color: AppColors.fontDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w(context),
                  ),
                  child: CommonButton(
                    text: controller.listening
                        ? "Listening... Go ahead!"
                        : AppStrings.updateIngredientWithSpeech,
                    backgroundColor: AppColors.primary,
                    width: 196.w(context),
                    textColor: AppColors.white,
                    onTap: () => controller.getText(),
                  ),
                ),
                SizedBox(
                  height: 5.h(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w(context),
                  ),
                  child: CommonButton(
                    text: AppStrings.addIngredient,
                    backgroundColor: AppColors.primary,
                    width: 196.w(context),
                    textColor: AppColors.white,
                    onTap: () => controller.addIngredient(),
                  ),
                ),
                SizedBox(
                  height: 11.h(context),
                ),
                CommonBottomBar(
                  selectedTab: AppStrings.storage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
