import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/ingredients_controller.dart';

class IngredientsView extends GetView<IngredientsController> {
  const IngredientsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IngredientsController>(
      init: IngredientsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 38.5.h(context),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 11.w(context),
                ),
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
              SizedBox(
                height: 11.h(context),
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
              if (controller.ingredients.isEmpty)
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
                        for (Map ingredient in controller.ingredients)
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
                                      fontSize: 10.t(context),
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
                      : AppStrings.addIngredientWithSpeech,
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
        );
      },
    );
  }
}
