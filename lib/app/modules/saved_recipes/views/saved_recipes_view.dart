import '../../../helper/all_imports.dart';
import '../controllers/saved_recipes_controller.dart';

class SavedRecipesView extends GetView<SavedRecipesController> {
  const SavedRecipesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedRecipesController>(
      init: SavedRecipesController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: controller.recipe != null
                ? Stack(
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
                                      minHeight: 217.h(context),
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 11.w(context)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                  text: controller
                                                      .recipe!["recipe_title"],
                                                  width: 184.w(context),
                                                  centered: true,
                                                  maxLines: null,
                                                  textAlign: TextAlign.center,
                                                  style: Styles.semiBold(
                                                    fontSize: 14.t(context),
                                                    color: AppColors.black,
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
                                                        text:
                                                            ingredient["label"]
                                                                .toString(),
                                                        maxLines: null,
                                                        width: 120.w(context),
                                                        style: Styles.regular(
                                                          fontSize:
                                                              9.t(context),
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
                                                        width: 48.w(context),
                                                        maxLines: null,
                                                        style: Styles.regular(
                                                          fontSize:
                                                              8.t(context),
                                                          color: AppColors
                                                              .fontGrey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.h(context)),
                                                  child: Container(
                                                    width: 198.w(context),
                                                    height: 1,
                                                    color: AppColors.stroke,
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
                          Row(
                            children: [
                              Expanded(
                                child: CommonButton(
                                  text: AppStrings.saveRecipe,
                                  backgroundColor: AppColors.cardColor,
                                  textColor: AppColors.fontDark,
                                  onTap: () => controller
                                      .deleteRecipe(controller.recipe!["id"]),
                                ),
                              ),
                              SizedBox(width: 8.w(context)),
                              Expanded(
                                child: CommonButton(
                                  text: AppStrings.startCooking,
                                  onTap: () => Get.toNamed(Routes.RECIPE,
                                      arguments: controller.recipe),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h(context),
                          ),
                        ],
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
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w(context),
                          ),
                          child: FirestorePagination(
                            query: FirebaseFirestore.instance
                                .collection("users")
                                .doc(controller.user?.uid)
                                .collection("saved_recipes")
                                .orderBy("saved_at", descending: true),
                            itemBuilder: (context, docs, index) {
                              final recipe =
                                  docs[index].data() as Map<String, dynamic>;
                              return Container(
                                margin: EdgeInsets.only(bottom: 12.h(context)),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.stroke,
                                    width: 0.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      child: Image.network(
                                        getKey(recipe, ["recipe_image"], ""),
                                        width: double.infinity,
                                        height: 120.h(context),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: double.infinity,
                                            height: 120.h(context),
                                            color: AppColors.cardColor,
                                            child: Icon(
                                              Icons.image,
                                              color: AppColors.fontGrey,
                                              size: 40.t(context),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12.h(context)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: AppText(
                                                  text: getKey(recipe,
                                                      ["recipe_title"], ""),
                                                  style: Styles.bold(
                                                    color: AppColors.fontDark,
                                                    fontSize: 12.t(context),
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    controller.deleteRecipe(
                                                  getKey(recipe, ["id"], ""),
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      6.h(context)),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                    size: 16.t(context),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.h(context)),
                                          AppText(
                                            text: getKey(
                                                recipe, ["recipe_type"], ""),
                                            style: Styles.regular(
                                              color: AppColors.fontGrey,
                                              fontSize: 9.t(context),
                                            ),
                                          ),
                                          SizedBox(height: 8.h(context)),
                                          // Statistics
                                          if (getKey(recipe, ["statistics"],
                                                  null) !=
                                              null)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12.w(context),
                                                vertical: 8.h(context),
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  for (String stat in getKey(
                                                      recipe,
                                                      ["statistics"],
                                                      {}).keys)
                                                    Column(
                                                      children: [
                                                        AppText(
                                                          text: getKey(
                                                                  recipe,
                                                                  [
                                                                    "statistics",
                                                                    stat
                                                                  ],
                                                                  "0")
                                                              .toString(),
                                                          style: Styles.bold(
                                                            fontSize:
                                                                10.t(context),
                                                            color: AppColors
                                                                .fontDark,
                                                          ),
                                                        ),
                                                        AppText(
                                                          text: stat
                                                              .capitalizeFirst
                                                              .toString(),
                                                          style: Styles.regular(
                                                            fontSize:
                                                                8.t(context),
                                                            color: AppColors
                                                                .fontGrey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(height: 12.h(context)),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CommonButton(
                                                  text: AppStrings.startCooking,
                                                  onTap: () => controller
                                                      .startCooking(recipe),
                                                ),
                                              ),
                                              SizedBox(width: 8.w(context)),
                                              GestureDetector(
                                                onTap: () => controller
                                                    .expandRecipe(recipe),
                                                child: Container(
                                                  width: 40.w(context),
                                                  height: 28.h(context),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Icon(
                                                    Icons.expand,
                                                    color: AppColors.fontDark,
                                                    size: 16.t(context),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            isLive: true,
                            limit: 10,
                            viewType: ViewType.list,
                            shrinkWrap: false,
                            onEmpty: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.bookmark_outline,
                                    size: 64.t(context),
                                    color: AppColors.fontGrey,
                                  ),
                                  SizedBox(height: 16.h(context)),
                                  AppText(
                                    text: AppStrings.noSavedRecipes,
                                    style: Styles.bold(
                                      color: AppColors.fontDark,
                                      fontSize: 14.t(context),
                                    ),
                                  ),
                                  SizedBox(height: 8.h(context)),
                                  AppText(
                                    text: AppStrings.saveRecipesToSeeHere,
                                    style: Styles.regular(
                                      color: AppColors.fontGrey,
                                      fontSize: 10.t(context),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      CommonBottomBar(
                        selectedTab: AppStrings.saved,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
