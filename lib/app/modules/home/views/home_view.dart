import '../../../helper/all_imports.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.recipes == null)
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
                                    AppRichText(
                                      text: TextSpan(
                                        text: "${greet()} \n",
                                        children: [
                                          TextSpan(
                                            text: getKey(
                                                userDetails, ["name"], ""),
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

                                    // Browse Features Section
                                    AppText(
                                      text: AppStrings.browseFeatures,
                                      style: Styles.bold(
                                        color: AppColors.fontDark,
                                        fontSize: 10.5.t(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h(context),
                                    ),
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        autoPlay: false,
                                        height: 90.h(context),
                                        viewportFraction: 0.95,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.zoom,
                                        enlargeCenterPage: true,
                                      ),
                                      items: [
                                        // Voice Recognition Feature
                                        Container(
                                          height: 90.h(context),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              width: 0.5,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w(context),
                                            vertical: 5.h(context),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 2.w(context),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: AppStrings
                                                    .recordIngredientsToUpdatePantry,
                                                height: 17.h(context),
                                                style: Styles.semiBold(
                                                  fontSize: 9.t(context),
                                                  color: AppColors.fontDark,
                                                ),
                                                maxLines: 2,
                                              ),
                                              SizedBox(height: 2.h(context)),
                                              AppText(
                                                text: AppStrings
                                                    .recordIngredientsToUpdatePantryDetailed,
                                                height: 30.h(context),
                                                style: Styles.regular(
                                                  fontSize: 8.t(context),
                                                  color: AppColors.fontGrey,
                                                ),
                                                maxLines: null,
                                              ),
                                              SizedBox(height: 2.h(context)),
                                              StreamBuilder(
                                                  stream: controller
                                                      .speechToIngredients
                                                      .listening
                                                      .stream,
                                                  builder: (context, snapshot) {
                                                    bool listening = false;
                                                    if (snapshot.hasData) {
                                                      listening =
                                                          snapshot.data ??
                                                              listening;
                                                    }
                                                    return CommonButton(
                                                      text: listening
                                                          ? "Listening... Go ahead!"
                                                          : AppStrings.tryItOut,
                                                      backgroundColor:
                                                          AppColors.primary,
                                                      width: 196.w(context),
                                                      textColor:
                                                          AppColors.white,
                                                      onTap: () => controller
                                                          .speechToIngredients
                                                          .getText(
                                                              controller.user!),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),

                                        // AI Recipe Generation Feature
                                        Container(
                                          height: 90.h(context),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              width: 0.5,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w(context),
                                            vertical: 5.h(context),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 2.w(context),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: AppStrings
                                                    .aiCookingAssistant,
                                                height: 17.h(context),
                                                style: Styles.semiBold(
                                                  fontSize: 9.t(context),
                                                  color: AppColors.fontDark,
                                                ),
                                                maxLines: 2,
                                              ),
                                              SizedBox(height: 2.h(context)),
                                              AppText(
                                                text: AppStrings
                                                    .aiCookingAssistantDetailed,
                                                height: 30.h(context),
                                                style: Styles.regular(
                                                  fontSize: 8.t(context),
                                                  color: AppColors.fontGrey,
                                                ),
                                                maxLines: null,
                                              ),
                                              SizedBox(height: 2.h(context)),
                                              CommonButton(
                                                text: AppStrings.generateRecipe,
                                                backgroundColor:
                                                    AppColors.primary,
                                                width: 196.w(context),
                                                textColor: AppColors.white,
                                                onTap: () => Get.toNamed(
                                                    Routes.GENERATE_RECIPE),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Smart Shopping List Feature
                                        Container(
                                          height: 90.h(context),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              width: 0.5,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w(context),
                                            vertical: 5.h(context),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 2.w(context),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: AppStrings
                                                    .smartShoppingList,
                                                height: 17.h(context),
                                                style: Styles.semiBold(
                                                  fontSize: 9.t(context),
                                                  color: AppColors.fontDark,
                                                ),
                                                maxLines: 2,
                                              ),
                                              SizedBox(height: 2.h(context)),
                                              AppText(
                                                text: AppStrings
                                                    .createShoppingList,
                                                height: 30.h(context),
                                                style: Styles.regular(
                                                  fontSize: 8.t(context),
                                                  color: AppColors.fontGrey,
                                                ),
                                                maxLines: null,
                                              ),
                                              SizedBox(height: 2.h(context)),
                                              CommonButton(
                                                text:
                                                    AppStrings.viewShoppingList,
                                                backgroundColor:
                                                    AppColors.primary,
                                                width: 196.w(context),
                                                textColor: AppColors.white,
                                                onTap: () => Get.toNamed(
                                                    Routes.SHOPPING_LIST),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h(context),
                                    ),

                                    // Quick Overview Section
                                    AppText(
                                      text: AppStrings.quickOverview,
                                      style: Styles.bold(
                                        color: AppColors.fontDark,
                                        fontSize: 10.5.t(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h(context),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w(context),
                                              vertical: 12.h(context)),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: AppColors.primary
                                                  .withOpacity(0.3),
                                              width: 0.5,
                                            ),
                                          ),
                                          width: 90.w(context),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.inventory_2_outlined,
                                                    color: AppColors.primary,
                                                    size: 10.t(context),
                                                  ),
                                                  SizedBox(width: 4.w(context)),
                                                  AppText(
                                                    text: AppStrings.myPantry,
                                                    width: 65.w(context) -
                                                        10.t(context),
                                                    style: Styles.semiBold(
                                                      fontSize: 9.t(context),
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4.h(context)),
                                              AppText(
                                                text: "${ingredients.length}",
                                                style: Styles.bold(
                                                  fontSize: 18.t(context),
                                                  color: AppColors.fontDark,
                                                ),
                                              ),
                                              AppText(
                                                text: AppStrings
                                                    .ingredientsAvailable,
                                                style: Styles.regular(
                                                  fontSize: 7.t(context),
                                                  color: AppColors.fontGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10.w(context)),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w(context),
                                              vertical: 12.h(context)),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondary
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: AppColors.secondary
                                                  .withOpacity(0.3),
                                              width: 0.5,
                                            ),
                                          ),
                                          width: 90.w(context),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.bookmark_outlined,
                                                    color: AppColors.secondary,
                                                    size: 10.t(context),
                                                  ),
                                                  SizedBox(width: 4.w(context)),
                                                  AppText(
                                                    text:
                                                        AppStrings.savedRecipes,
                                                    width: 65.w(context) -
                                                        10.t(context),
                                                    style: Styles.semiBold(
                                                      fontSize: 9.t(context),
                                                      color:
                                                          AppColors.secondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4.h(context)),
                                              StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(controller.user?.uid)
                                                    .collection("saved_recipes")
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return AppText(
                                                      text: "0",
                                                      style: Styles.bold(
                                                        fontSize: 18.t(context),
                                                        color:
                                                            AppColors.fontDark,
                                                      ),
                                                    );
                                                  }
                                                  return AppText(
                                                    text:
                                                        "${snapshot.data!.docs.length}",
                                                    style: Styles.bold(
                                                      fontSize: 18.t(context),
                                                      color: AppColors.fontDark,
                                                    ),
                                                  );
                                                },
                                              ),
                                              AppText(
                                                text: AppStrings.recipesSaved,
                                                style: Styles.regular(
                                                  fontSize: 7.t(context),
                                                  color: AppColors.fontGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h(context),
                                    ),

                                    // Quick Actions Section
                                    AppText(
                                      text: AppStrings.quickActions,
                                      style: Styles.bold(
                                        color: AppColors.fontDark,
                                        fontSize: 10.5.t(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h(context),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () =>
                                                Get.toNamed(Routes.INGREDIENTS),
                                            child: Container(
                                              padding:
                                                  EdgeInsets.all(8.w(context)),
                                              decoration: BoxDecoration(
                                                color: AppColors.cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: AppColors.stroke,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .local_grocery_store_outlined,
                                                    color: AppColors.primary,
                                                    size: 20.t(context),
                                                  ),
                                                  SizedBox(
                                                      height: 4.h(context)),
                                                  AppText(
                                                    text: AppStrings
                                                        .manageIngredients,
                                                    style: Styles.medium(
                                                      fontSize: 8.t(context),
                                                      color: AppColors.fontDark,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w(context)),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => Get.toNamed(
                                                Routes.SHOPPING_LIST),
                                            child: Container(
                                              padding:
                                                  EdgeInsets.all(8.w(context)),
                                              decoration: BoxDecoration(
                                                color: AppColors.cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: AppColors.stroke,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    color: AppColors.primary,
                                                    size: 20.t(context),
                                                  ),
                                                  SizedBox(
                                                      height: 4.h(context)),
                                                  AppText(
                                                    text: AppStrings
                                                        .viewShoppingList,
                                                    style: Styles.medium(
                                                      fontSize: 8.t(context),
                                                      color: AppColors.fontDark,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.w(context)),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => Get.toNamed(
                                                Routes.GENERATE_RECIPE),
                                            child: Container(
                                              padding:
                                                  EdgeInsets.all(8.w(context)),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: AppColors.primary,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.auto_awesome,
                                                    color: AppColors.primary,
                                                    size: 20.t(context),
                                                  ),
                                                  SizedBox(
                                                      height: 4.h(context)),
                                                  AppText(
                                                    text: AppStrings
                                                        .generateNewRecipe,
                                                    style: Styles.medium(
                                                      fontSize: 8.t(context),
                                                      color: AppColors.primary,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h(context),
                                    ),

                                    // Saved Recipes Section
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(controller.user?.uid)
                                          .collection("saved_recipes")
                                          .limit(1)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return SizedBox.shrink();
                                        }

                                        bool hasRecipes =
                                            snapshot.data!.docs.isNotEmpty;

                                        if (!hasRecipes) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text: AppStrings.savedRecipes,
                                                style: Styles.bold(
                                                  color: AppColors.fontDark,
                                                  fontSize: 10.5.t(context),
                                                ),
                                              ),
                                              SizedBox(height: 8.h(context)),
                                              Container(
                                                width: 190.w(context),
                                                padding: EdgeInsets.all(
                                                    16.h(context)),
                                                decoration: BoxDecoration(
                                                  color: AppColors.cardColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.bookmark_outline,
                                                      size: 24.t(context),
                                                      color: AppColors.fontGrey,
                                                    ),
                                                    SizedBox(
                                                        height: 8.h(context)),
                                                    AppText(
                                                      text: AppStrings
                                                          .noSavedRecipes,
                                                      style: Styles.medium(
                                                        color:
                                                            AppColors.fontDark,
                                                        fontSize: 9.t(context),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: 4.h(context)),
                                                    AppText(
                                                      text: AppStrings
                                                          .saveRecipesToSeeHere,
                                                      style: Styles.regular(
                                                        color:
                                                            AppColors.fontGrey,
                                                        fontSize: 7.t(context),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText(
                                                  text: AppStrings.savedRecipes,
                                                  style: Styles.bold(
                                                    color: AppColors.fontDark,
                                                    fontSize: 10.5.t(context),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        Routes.SAVED_RECIPES);
                                                  },
                                                  child: AppText(
                                                    text: AppStrings.viewAll,
                                                    style: Styles.medium(
                                                      color: AppColors.primary,
                                                      fontSize: 8.t(context),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8.h(context)),
                                            SizedBox(
                                              height: 100.h(context),
                                              child: FirestorePagination(
                                                query: FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(controller.user?.uid)
                                                    .collection("saved_recipes")
                                                    .orderBy("saved_at",
                                                        descending: true),
                                                itemBuilder:
                                                    (context, docs, index) {
                                                  final recipe = docs[index]
                                                          .data()
                                                      as Map<String, dynamic>;
                                                  return Container(
                                                    width: 130.w(context),
                                                    margin: EdgeInsets.only(
                                                        right: 8.w(context)),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: AppColors.stroke,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                          child: Image.network(
                                                            getKey(
                                                                recipe,
                                                                [
                                                                  "recipe_image"
                                                                ],
                                                                ""),
                                                            width:
                                                                130.w(context),
                                                            height:
                                                                60.h(context),
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Container(
                                                                width: 130
                                                                    .w(context),
                                                                height: 60
                                                                    .h(context),
                                                                color: AppColors
                                                                    .cardColor,
                                                                child: Icon(
                                                                  Icons.image,
                                                                  color: AppColors
                                                                      .fontGrey,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 6.w(
                                                                      context),
                                                                  vertical: 6.h(
                                                                      context)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  AppText(
                                                                    text: getKey(
                                                                        recipe,
                                                                        [
                                                                          "recipe_title"
                                                                        ],
                                                                        ""),
                                                                    style: Styles
                                                                        .medium(
                                                                      color: AppColors
                                                                          .fontDark,
                                                                      fontSize:
                                                                          8.t(context),
                                                                    ),
                                                                    minFontSize: 8
                                                                        .t(context)
                                                                        .floorToDouble(),
                                                                    width: 110.w(
                                                                            context) -
                                                                        16.t(
                                                                            context),
                                                                    height: 14.h(
                                                                        context),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  SizedBox(
                                                                      height: 2.h(
                                                                          context)),
                                                                  AppText(
                                                                    text: getKey(
                                                                        recipe,
                                                                        [
                                                                          "recipe_type"
                                                                        ],
                                                                        ""),
                                                                    minFontSize: 6
                                                                        .t(context)
                                                                        .floorToDouble(),
                                                                    height: 10.h(
                                                                        context),
                                                                    width: 110.w(
                                                                            context) -
                                                                        16.t(
                                                                            context),
                                                                    style: Styles
                                                                        .regular(
                                                                      color: AppColors
                                                                          .fontGrey,
                                                                      fontSize:
                                                                          6.t(context),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              GestureDetector(
                                                                onTap: () => controller
                                                                    .startCooking(
                                                                        recipe),
                                                                child: Icon(
                                                                  Icons
                                                                      .play_circle_fill,
                                                                  color: AppColors
                                                                      .primary,
                                                                  size: 16.t(
                                                                      context),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                isLive: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                limit: 5,
                                                viewType: ViewType.list,
                                                shrinkWrap: true,
                                                onEmpty: Container(
                                                  padding: EdgeInsets.all(
                                                      16.h(context)),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.bookmark_outline,
                                                        size: 24.t(context),
                                                        color:
                                                            AppColors.fontGrey,
                                                      ),
                                                      SizedBox(
                                                          height: 8.h(context)),
                                                      AppText(
                                                        text: AppStrings
                                                            .noSavedRecipes,
                                                        style: Styles.medium(
                                                          color: AppColors
                                                              .fontDark,
                                                          fontSize:
                                                              9.t(context),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.h(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  CommonBottomBar(
                    selectedTab: AppStrings.home,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
