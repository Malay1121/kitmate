import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/modules/generate_recipe/views/form_view.dart';

import '../controllers/generate_recipe_controller.dart';

class GenerateRecipeView extends GetView<GenerateRecipeController> {
  const GenerateRecipeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GenerateRecipeController>(
        init: GenerateRecipeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: generatedRecipes.isNotEmpty && generatedRecipe == null
                  ? Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w(context),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40.h(context),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // AppRichText(
                                      //   text: TextSpan(
                                      //     text: "${greet()} \n",
                                      //     children: [
                                      //       TextSpan(
                                      //         text: getKey(
                                      //             userDetails, ["name"], ""),
                                      //         style: Styles.bold(
                                      //           color: AppColors.primary,
                                      //           fontSize: 12.t(context),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   width: 160.w(context),
                                      //   style: Styles.bold(
                                      //     color: AppColors.fontDark,
                                      //     fontSize: 12.t(context),
                                      //   ),
                                      //   maxLines: null,
                                      // ),
                                      AppText(
                                        text: AppStrings.recipeOptions,
                                        style: Styles.bold(
                                          color: AppColors.fontDark,
                                          fontSize: 12.t(context),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          generatedRecipes.clear();
                                          controller.update();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: AppColors.black,
                                          size: 14.t(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h(context),
                                  ),
                                  for (Map recipe in generatedRecipes)
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.white,
                                        border: Border.all(
                                          width: 0.48,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: 10.h(context),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w(context),
                                        vertical: 10.h(context),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  getKey(recipe,
                                                      ["recipe_image"], ""),
                                                  width: 50.w(context),
                                                  height: 50.h(context),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      SizedBox(
                                                          width: 50.w(context),
                                                          height: 50.h(context),
                                                          child: Icon(
                                                              Icons.error)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w(context),
                                              ),
                                              Column(
                                                children: [
                                                  AppText(
                                                    text: getKey(recipe,
                                                        ["recipe_title"], ""),
                                                    width: 110.w(context),
                                                    height: 25.h(context),
                                                    maxLines: 2,
                                                    minFontSize: 8
                                                        .t(context)
                                                        .floorToDouble(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Styles.bold(
                                                      fontSize: 10.t(context),
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h(context),
                                                    width: 110.w(context),
                                                    child: Wrap(
                                                      alignment:
                                                          WrapAlignment.start,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      runAlignment:
                                                          WrapAlignment
                                                              .spaceBetween,
                                                      spacing: 10.w(context),
                                                      direction:
                                                          Axis.horizontal,
                                                      children: [
                                                        for (String stat
                                                            in getKey(
                                                                recipe,
                                                                ["statistics"],
                                                                {}).keys)
                                                          SizedBox(
                                                            width:
                                                                50.w(context),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                AppText(
                                                                  text: getKey(
                                                                          recipe,
                                                                          [
                                                                            "statistics",
                                                                            stat
                                                                          ],
                                                                          "")
                                                                      .toString(),
                                                                  style: Styles
                                                                      .medium(
                                                                    fontSize: 8.t(
                                                                        context),
                                                                    color: AppColors
                                                                        .fontDark,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w(
                                                                      context),
                                                                ),
                                                                AppText(
                                                                  text: stat
                                                                      .toString()
                                                                      .capitalizeFirst
                                                                      .toString(),
                                                                  width: 25.w(
                                                                      context),
                                                                  style: Styles
                                                                      .regular(
                                                                    fontSize: 7.t(
                                                                        context),
                                                                    color: AppColors
                                                                        .fontDark,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h(context),
                                          ),
                                          AppText(
                                            text: AppStrings.ingredients,
                                            width: 109.w(context),
                                            style: Styles.semiBold(
                                              fontSize: 9.t(context),
                                              color: AppColors.fontDark,
                                            ),
                                          ),
                                          for (Map ingredient in getKey(
                                              recipe, ["ingredients"], []))
                                            Row(
                                              children: [
                                                AppText(
                                                  text: ingredient["label"],
                                                  width: 109.w(context),
                                                  minFontSize: 8
                                                      .t(context)
                                                      .floorToDouble(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Styles.medium(
                                                    fontSize: 8.t(context),
                                                    color: AppColors.fontDark,
                                                  ),
                                                ),
                                                Spacer(),
                                                AppText(
                                                  text:
                                                      "${ingredient["quantity"]} ${ingredient["quantity_unit"]}"
                                                          .replaceAll(
                                                              "(1,2,3,4...)",
                                                              ""),
                                                  width: 55.w(context),
                                                  style: Styles.regular(
                                                    fontSize: 7.t(context),
                                                    color: AppColors.fontDark,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          SizedBox(
                                            height: 10.h(context),
                                          ),
                                          Row(
                                            children: [
                                              CommonButton(
                                                text: AppStrings.startCooking,
                                                onTap: () => controller
                                                    .startCooking(recipe),
                                                width: 100.w(context),
                                              ),
                                              SizedBox(
                                                width: 4.w(context),
                                              ),
                                              GestureDetector(
                                                onTap: () => controller
                                                    .saveRecipe(recipe, false),
                                                child: Container(
                                                  width: 28.h(context),
                                                  height: 28.h(context),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: AppColors.primary,
                                                  ),
                                                  child: Icon(
                                                    Icons.bookmark_add,
                                                    size: 12.t(context),
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4.w(context),
                                              ),
                                              GestureDetector(
                                                onTap: () => controller
                                                    .expandRecipe(recipe),
                                                child: Container(
                                                  width: 28.h(context),
                                                  height: 28.h(context),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: AppColors.cardColor,
                                                  ),
                                                  child: Icon(
                                                    Icons.expand,
                                                    size: 12.t(context),
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                    height: 10.h(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CommonBottomBar(selectedTab: AppStrings.generateRecipe)
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h(context),
                          ),
                          AppText(
                            text: AppStrings.generateRecipe,
                            style: Styles.bold(
                              color: AppColors.fontDark,
                              fontSize: 15.t(context),
                            ),
                          ),
                          SizedBox(
                            height: 10.h(context),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.settingsData.keys.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Map question = controller.settingsData[
                                    controller.settingsData.keys
                                        .toList()[index]];
                                String questionId = controller.settingsData.keys
                                    .toList()[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text:
                                          "${AppStrings.question.toUpperCase()} ${index + 1}",
                                      width: 196.w(context),
                                      maxLines: null,
                                      style: Styles.regular(
                                        color: AppColors.primary,
                                        fontSize: 8.t(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h(context),
                                    ),
                                    Row(
                                      children: [
                                        AppText(
                                          text:
                                              getKey(question, ["label"], "") +
                                                  "?",
                                          // width: 196.w(context),
                                          maxLines: null,
                                          style: Styles.medium(
                                            color: AppColors.fontDark,
                                            fontSize: 12.t(context),
                                          ),
                                        ),
                                        if (getKey(question, ["pro"], false))
                                          GestureDetector(
                                            onTap: () => proPopup(),
                                            child: Container(
                                              width: 20.w(context),
                                              height: 20.h(context),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    AppImages.icProBadge,
                                                  ),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h(context),
                                    ),
                                    AppText(
                                      text:
                                          getKey(question, ["description"], ""),
                                      width: 196.w(context),
                                      maxLines: null,
                                      style: Styles.regular(
                                        color: AppColors.fontGrey,
                                        fontSize: 7.5.t(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h(context),
                                    ),
                                    FormView(
                                        id: questionId, controller: controller),
                                    // getKey(question, ["child"], Container()),
                                    SizedBox(
                                      height: 15.h(context),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          CommonButton(
                            text: AppStrings.generateRecipe,
                            onTap: () => controller.generateRecipes(),
                          ),
                          SizedBox(
                            height: 10.h(context),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
