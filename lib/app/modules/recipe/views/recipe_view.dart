import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/all_imports.dart';
import '../controllers/recipe_controller.dart';

class RecipeView extends GetView<RecipeController> {
  const RecipeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeController>(
        init: RecipeController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.recipe == null)
                        SizedBox(
                          height: 20.h(context),
                        ),
                      if (controller.recipe == null)
                        AppText(
                          text: AppStrings.generatingARecipe,
                          centered: true,
                          textAlign: TextAlign.center,
                          width: 160.w(context),
                          style: Styles.bold(
                            color: AppColors.fontDark,
                            fontSize: 12.t(context),
                          ),
                          maxLines: null,
                        ),
                      if (controller.recipe == null) Spacer(),
                      if (controller.recipe != null)
                        Expanded(
                          child: Stack(
                            children: [
                              // SizedBox(
                              //   height: 442.h(context),
                              // ),
                              Image.network(
                                controller.recipe!["recipe_image"],
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.cardColor,
                                    width: 220.w(context),
                                    height: 215.h(context),
                                    child: Icon(Icons.image),
                                  );
                                },
                                fit: BoxFit.cover,
                                width: 220.w(context),
                                height: 215.h(context),
                              ),
                              Positioned(
                                top: 187.h(context),
                                child: Container(
                                  width: 220.w(context),
                                  constraints: BoxConstraints(
                                    minHeight: 290.h(context),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(28),
                                      topLeft: Radius.circular(28),
                                    ),
                                    color: AppColors.white,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 11.h(context),
                                        ),
                                        AppText(
                                          text: "${AppStrings.step} " +
                                              controller
                                                  .steps[controller.currentStep]
                                                      ["step_no"]
                                                  .toString(),
                                          style: Styles.semiBold(
                                            fontSize: 14.t(context),
                                            color: AppColors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7.h(context),
                                        ),
                                        Wrap(
                                          children: [
                                            for (Map<String, dynamic> step
                                                in controller.steps)
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 2.52.w(context),
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: controller.steps
                                                                .indexOf(
                                                                    step) ==
                                                            controller
                                                                .currentStep
                                                        ? Colors.transparent
                                                        : AppColors.black,
                                                    width: 0.53,
                                                  ),
                                                  color: controller.steps
                                                              .indexOf(step) ==
                                                          controller.currentStep
                                                      ? AppColors.primary
                                                      : Colors.transparent,
                                                ),
                                                height: 13.77.h(context),
                                                width: 13.77.w(context),
                                                child: Center(
                                                  child: AppText(
                                                    text: step["step_no"]
                                                        .toString(),
                                                    centered: true,
                                                    style: Styles.regular(
                                                      color: controller.steps
                                                                  .indexOf(
                                                                      step) ==
                                                              controller
                                                                  .currentStep
                                                          ? AppColors.white
                                                          : AppColors.fontDark,
                                                      fontSize: 7.42.t(context),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h(context),
                                        ),
                                        for (Map ingredient in controller
                                                .steps[controller.currentStep]
                                            ["ingredients_req"])
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 11.w(context),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 11.w(context),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppText(
                                                        text: ingredient["name"]
                                                            .toString(),
                                                        style: Styles.medium(
                                                          fontSize:
                                                              9.5.t(context),
                                                          color: AppColors
                                                              .fontDark,
                                                        ),
                                                      ),
                                                      AppText(
                                                        text: ingredient[
                                                                "quantity"]
                                                            .toString(),
                                                        style: Styles.regular(
                                                          fontSize:
                                                              8.t(context),
                                                          color: AppColors
                                                              .fontDark,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h(context),
                                                ),
                                                Container(
                                                  height: 1,
                                                  width: 191.w(context),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.cardColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h(context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        SizedBox(
                                          height: 11.5.h(context),
                                        ),
                                        AppText(
                                          text: controller
                                              .steps[controller.currentStep]
                                                  ["procedure"]
                                              .toString(),
                                          maxLines: null,
                                          width: 174.w(context),
                                          style: Styles.regular(
                                            fontSize: 9.t(context),
                                            color: AppColors.fontDark,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h(context),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CommonButton(
                                              text: 0 >= controller.currentStep
                                                  ? AppStrings.exit
                                                  : AppStrings.previous,
                                              backgroundColor:
                                                  AppColors.cardColor,
                                              textColor: AppColors.fontDark,
                                              onTap: () =>
                                                  controller.previousStep(),
                                              width: 90.w(context),
                                              height: 26.h(context),
                                            ),
                                            SizedBox(
                                              width: 12.w(context),
                                            ),
                                            CommonButton(
                                              text: controller.steps.length <=
                                                      controller.currentStep + 1
                                                  ? AppStrings.finish
                                                  : AppStrings.next,
                                              onTap: () =>
                                                  controller.nextStep(),
                                              width: 90.w(context),
                                              height: 26.h(context),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                CommonBottomBar(
                  selectedTab: AppStrings.mealPlans,
                ),
              ],
            ),
          );
        });
  }
}
