import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/all_imports.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
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
                                      children: [
                                        SizedBox(
                                          height: 11.h(context),
                                        ),
                                        AppText(
                                          text: controller
                                              .recipe!["recipe_title"],
                                          style: Styles.semiBold(
                                            fontSize: 14.t(context),
                                            color: AppColors.black,
                                          ),
                                        ),
                                        AppText(
                                          text:
                                              "${controller.recipe!["recipe_type"]} / ${controller.recipe!["time"]}",
                                          style: Styles.semiBold(
                                            fontSize: 7.t(context),
                                            color: AppColors.fontGrey,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h(context),
                                        ),
                                        Container(
                                          height: 34.h(context),
                                          width: 220.w(context),
                                          decoration: BoxDecoration(
                                            color: AppColors.cardColor,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              for (String stat in controller
                                                  .recipe!["statistics"].keys)
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AppText(
                                                      text: controller
                                                          .recipe!["statistics"]
                                                              [stat]
                                                          .toString(),
                                                      style: Styles.regular(
                                                        fontSize: 7.t(context),
                                                        color:
                                                            AppColors.fontDark,
                                                      ),
                                                    ),
                                                    AppText(
                                                      text: stat
                                                          .toString()
                                                          .capitalizeFirst
                                                          .toString(),
                                                      style: Styles.medium(
                                                        fontSize: 9.t(context),
                                                        color:
                                                            AppColors.fontDark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 11.5.h(context),
                                        ),
                                        for (Map ingredient in controller
                                            .recipe!["ingredients"])
                                          SizedBox(
                                            width: 220.w(context),
                                            child: Padding(
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
                                                    style: Styles.regular(
                                                      fontSize: 9.t(context),
                                                      color: AppColors.fontDark,
                                                    ),
                                                  ),
                                                  AppText(
                                                    text: ingredient["quantity"]
                                                        .toString(),
                                                    style: Styles.regular(
                                                      fontSize: 8.t(context),
                                                      color: AppColors.fontGrey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          height: 10.h(context),
                                        ),
                                        CommonButton(
                                          text: AppStrings.startCooking,
                                          onTap: () => {},
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
