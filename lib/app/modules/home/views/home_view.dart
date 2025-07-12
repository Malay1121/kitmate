import 'package:kitmate/app/modules/home/views/settings_view.dart';

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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w(context),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50.h(context),
                                ),
                                AppRichText(
                                  text: TextSpan(
                                    text: "${greet()} \n",
                                    children: [
                                      TextSpan(
                                        text: getKey(userDetails, ["name"], ""),
                                        style: Styles.bold(
                                          color: AppColors.primary,
                                          fontSize: 12.t(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  width: 160.w(context),
                                  style: Styles.bold(
                                    color: AppColors.fontDark,
                                    fontSize: 12.t(context),
                                  ),
                                  maxLines: null,
                                ),
                                SizedBox(
                                  height: 20.h(context),
                                ),
                                Expanded(
                                    child: SettingsView(
                                  controller: controller,
                                  customMessage: getKey(controller.settings,
                                      ["custom_message"], ""),
                                  servings: getKey(
                                      controller.settings, ["servings"], ""),
                                )),
                                SizedBox(
                                  height: 10.h(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (controller.recipe != null)
                        Expanded(
                          child: Stack(
                            children: [
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
                              Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 187.h(context),
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxHeight: 217.h(context),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(28),
                                                topLeft: Radius.circular(28),
                                              ),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 11.h(context),
                                                ),
                                                SizedBox(
                                                  width: 220.w(context),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                11.w(context)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () => controller
                                                              .generateRecipe(),
                                                          child: Icon(
                                                            Icons.restart_alt,
                                                            size: 14.t(context),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () => print(
                                                              ingredients),
                                                          child: AppText(
                                                            text: controller
                                                                    .recipe![
                                                                "recipe_title"],
                                                            width:
                                                                184.w(context),
                                                            centered: true,
                                                            maxLines: null,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                Styles.semiBold(
                                                              fontSize:
                                                                  14.t(context),
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 0,
                                                        ),
                                                      ],
                                                    ),
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      for (String stat
                                                          in controller
                                                              .recipe![
                                                                  "statistics"]
                                                              .keys)
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            AppText(
                                                              text: controller
                                                                  .recipe![
                                                                      "statistics"]
                                                                      [stat]
                                                                  .toString(),
                                                              style: Styles
                                                                  .regular(
                                                                fontSize: 7
                                                                    .t(context),
                                                                color: AppColors
                                                                    .fontDark,
                                                              ),
                                                            ),
                                                            AppText(
                                                              text: stat
                                                                  .toString()
                                                                  .capitalizeFirst
                                                                  .toString(),
                                                              style:
                                                                  Styles.medium(
                                                                fontSize: 9
                                                                    .t(context),
                                                                color: AppColors
                                                                    .fontDark,
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
                                                for (Map ingredient
                                                    in controller
                                                        .recipe!["ingredients"])
                                                  SizedBox(
                                                    width: 220.w(context),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                11.w(context),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              AppText(
                                                                text: ingredient[
                                                                        "label"]
                                                                    .toString(),
                                                                maxLines: null,
                                                                width: 120
                                                                    .w(context),
                                                                style: Styles
                                                                    .regular(
                                                                  fontSize: 9.t(
                                                                      context),
                                                                  color: AppColors
                                                                      .fontDark,
                                                                ),
                                                              ),
                                                              AppText(
                                                                text: getKey(
                                                                        ingredient,
                                                                        [
                                                                          "quantity_label"
                                                                        ],
                                                                        "")
                                                                    .toString(),
                                                                width: 48
                                                                    .w(context),
                                                                maxLines: null,
                                                                style: Styles
                                                                    .regular(
                                                                  fontSize: 8.t(
                                                                      context),
                                                                  color: AppColors
                                                                      .fontGrey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 2.h(
                                                                      context)),
                                                          child: Container(
                                                            width:
                                                                198.w(context),
                                                            height: 1,
                                                            color: AppColors
                                                                .stroke,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h(context),
                                  ),
                                  CommonButton(
                                    text: AppStrings.startCooking,
                                    onTap: () => Get.toNamed(Routes.RECIPE,
                                        arguments: controller.recipe),
                                  ),
                                  SizedBox(
                                    height: 10.h(context),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 20.h(context),
                                right: 15.w(context),
                                child: GestureDetector(
                                  onTap: () =>
                                      controller.settingsPopup(controller),
                                  child: Container(
                                    width: 30.w(context),
                                    height: 30.h(context),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.settings,
                                      color: AppColors.primary,
                                      size: 14.t(context),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20.h(context),
                                left: 15.w(context),
                                child: GestureDetector(
                                  onTap: () => controller.closeRecipe(),
                                  child: Container(
                                    width: 30.w(context),
                                    height: 30.h(context),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: AppColors.primary,
                                      size: 14.t(context),
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
