import 'package:kitmate/app/helper/all_imports.dart';

void expandedRecipePopup(User? user, Map<String, dynamic> recipe) async {
  Get.dialog(
    Dialog(
      shadowColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Image.network(
              recipe!["recipe_image"],
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.cardColor,
                  width: 220.w(Get.context!),
                  height: 215.h(Get.context!),
                  child: Icon(Icons.image),
                );
              },
              fit: BoxFit.cover,
              width: 220.w(Get.context!),
              height: 215.h(Get.context!),
            ),
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 187.h(Get.context!),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 217.h(Get.context!),
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
                                height: 11.h(Get.context!),
                              ),
                              SizedBox(
                                width: 220.w(Get.context!),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 11.w(Get.context!)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: recipe!["recipe_title"],
                                        width: 184.w(Get.context!),
                                        centered: true,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: Styles.semiBold(
                                          fontSize: 14.t(Get.context!),
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
                                    "${recipe!["recipe_type"]} / ${recipe!["time"]}",
                                style: Styles.semiBold(
                                  fontSize: 7.t(Get.context!),
                                  color: AppColors.fontGrey,
                                ),
                              ),
                              SizedBox(
                                height: 10.h(Get.context!),
                              ),
                              Container(
                                height: 34.h(Get.context!),
                                width: 220.w(Get.context!),
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (String stat
                                        in recipe!["statistics"].keys)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppText(
                                            text: recipe!["statistics"][stat]
                                                .toString(),
                                            style: Styles.regular(
                                              fontSize: 7.t(Get.context!),
                                              color: AppColors.fontDark,
                                            ),
                                          ),
                                          AppText(
                                            text: stat
                                                .toString()
                                                .capitalizeFirst
                                                .toString(),
                                            style: Styles.medium(
                                              fontSize: 9.t(Get.context!),
                                              color: AppColors.fontDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 11.5.h(Get.context!),
                              ),
                              for (Map ingredient in recipe!["ingredients"])
                                SizedBox(
                                  width: 220.w(Get.context!),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 11.w(Get.context!),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              text: ingredient["label"]
                                                  .toString(),
                                              maxLines: null,
                                              width: 120.w(Get.context!),
                                              style: Styles.regular(
                                                fontSize: 9.t(Get.context!),
                                                color: AppColors.fontDark,
                                              ),
                                            ),
                                            AppText(
                                              text: getKey(ingredient,
                                                      ["quantity_label"], "")
                                                  .toString(),
                                              width: 48.w(Get.context!),
                                              maxLines: null,
                                              style: Styles.regular(
                                                fontSize: 8.t(Get.context!),
                                                color: AppColors.fontGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.h(Get.context!)),
                                        child: Container(
                                          width: 198.w(Get.context!),
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
                  height: 5.h(Get.context!),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        text: AppStrings.saveRecipe,
                        backgroundColor: AppColors.cardColor,
                        textColor: AppColors.fontDark,
                        onTap: () => DatabaseHelper.saveRecipe(
                            userId: user?.uid ?? "", recipe: recipe),
                      ),
                    ),
                    SizedBox(width: 8.w(Get.context!)),
                    Expanded(
                      child: CommonButton(
                        text: AppStrings.startCooking,
                        onTap: () =>
                            Get.toNamed(Routes.RECIPE, arguments: recipe),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h(Get.context!),
                ),
              ],
            ),
            Positioned(
              top: 20.h(Get.context!),
              left: 15.w(Get.context!),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 30.w(Get.context!),
                  height: 30.h(Get.context!),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColors.primary,
                    size: 14.t(Get.context!),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
