import 'dart:math';

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
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              // alignment: Alignment.bottomRight,
              children: [
                if (controller.isDialOpen) ...[
                  Padding(
                    padding: EdgeInsets.only(),
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
                    padding: EdgeInsets.only(),
                    child: CommonButton(
                      text: AppStrings.addIngredientsFromBill,
                      backgroundColor: AppColors.primary,
                      width: 196.w(context),
                      textColor: AppColors.white,
                      onTap: () => controller.selectBillPicture(),
                    ),
                  ),
                  SizedBox(
                    height: 5.h(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: CommonButton(
                      text: AppStrings.addIngredient,
                      backgroundColor: AppColors.primary,
                      width: 196.w(context),
                      textColor: AppColors.white,
                      onTap: () => controller.addIngredient(),
                    ),
                  ),
                ],
                SizedBox(
                  height: 5.h(context),
                ),
                SizedBox(
                  width: min(32.h(context), 32.w(context)),
                  height: min(32.h(context), 32.w(context)),
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: "mainFab",
                      backgroundColor: const Color(0xFF8A47EB),
                      onPressed: () {
                        controller.isDialOpen = !controller.isDialOpen;
                        controller.update();
                      },
                      child: Icon(
                        controller.isDialOpen ? Icons.close : Icons.add,
                        size: 16.t(context),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h(context),
                ),
              ],
            ),
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
                  child: Row(
                    children: [
                      AppText(
                        text: AppStrings.ingredients,
                        maxLines: 2,
                        width: 160.w(context),
                        style: Styles.semiBold(
                          fontSize: 15.55.t(context),
                          color: AppColors.fontDark,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.SHOPPING_LIST),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 14.t(context),
                          color: AppColors.primary,
                        ),
                      ),
                    ],
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
                                    AppText(
                                      text:
                                          "${ingredient["quantity"]} ${ingredient["quantity_unit"]}"
                                              .replaceAll("(1,2,3,4...)", ""),
                                      width: 55.w(context),
                                      style: Styles.bold(
                                        fontSize: 7.t(context),
                                        color: AppColors.fontDark,
                                      ),
                                      textAlign: TextAlign.end,
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
                  height: 4.h(context),
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
