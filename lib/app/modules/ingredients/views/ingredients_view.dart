import 'dart:math';

import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/ingredients_controller.dart';

class IngredientsView extends GetView<IngredientsController> {
  const IngredientsView({Key? key}) : super(key: key);

  // Calculate dynamic ad height based on screen size
  double _calculateAdHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // For small native ads, use aspect ratio of approximately 2.7:1 (width:height)
    // Base height on screen width but with constraints
    double adHeight = screenWidth / 2.7;

    // Apply constraints to ensure reasonable size
    adHeight = adHeight.clamp(80.0, 140.0); // Min 80px, Max 140px

    // On smaller screens, reduce the height a bit more
    if (screenHeight < 700) {
      adHeight *= 0.9;
    }

    return adHeight;
  }

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
                  StreamBuilder(
                      stream: controller.speechToIngredients.listening.stream,
                      builder: (context, snapshot) {
                        bool listening = false;
                        if (snapshot.hasData) {
                          listening = snapshot.data ?? listening;
                        }
                        return CommonButton(
                          text: listening
                              ? "Listening... Go ahead!"
                              : AppStrings.updateIngredientWithSpeech,
                          backgroundColor: AppColors.primary,
                          width: 196.w(context),
                          textColor: AppColors.white,
                          onTap: () => controller.speechToIngredients
                              .getText(controller.user!),
                        );
                      }),
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
                  SizedBox(
                    height: 5.h(context),
                  ),
                ],
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
                          Builder(
                            builder: (context) {
                              final filteredIngredients = ingredients
                                  .where(
                                    (p0) => getKey(p0, ["label"], "")
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(controller.searchText
                                            .toLowerCase()),
                                  )
                                  .toList();

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredIngredients.length,
                                itemBuilder: (context, index) {
                                  final ingredient = filteredIngredients[index];

                                  return GestureDetector(
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
                                                    .replaceAll(
                                                        "(1,2,3,4...)", ""),
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
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  // Show ad after every 6 ingredients (0-indexed, so after items 5, 11, 17, etc.)
                                  if ((index + 1) % 6 == 0 &&
                                      index < filteredIngredients.length - 1 &&
                                      !controller.pro) {
                                    print(
                                        "Creating AdSeparatorWidget at index: $index");
                                    return Column(
                                      children: [
                                        SizedBox(height: 11.h(context)),
                                        Container(
                                          width: double.infinity,
                                          height: _calculateAdHeight(context),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.transparent,
                                          ),
                                          child: AdSeparatorWidget(
                                              key: ValueKey('ad_$index')),
                                        ),
                                        SizedBox(height: 11.h(context)),
                                      ],
                                    );
                                  }
                                  return SizedBox(height: 11.h(context));
                                },
                              );
                            },
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

class AdSeparatorWidget extends StatefulWidget {
  const AdSeparatorWidget({Key? key}) : super(key: key);

  @override
  State<AdSeparatorWidget> createState() => _AdSeparatorWidgetState();
}

class _AdSeparatorWidgetState extends State<AdSeparatorWidget> {
  NativeAd? _nativeAd;
  Timer? _retryTimer;

  @override
  void initState() {
    super.initState();
    // Try to load an ad immediately if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryLoadAd();
    });
  }

  void _tryLoadAd() {
    if (_nativeAd == null && mounted) {
      _nativeAd = AdMobManager.instance.getLoadedNativeAd();
      print(
          "AdSeparatorWidget: Loaded ad = ${_nativeAd != null ? 'SUCCESS' : 'NULL'}");
      print(
          "AdSeparatorWidget: Available ads count = ${AdMobManager.instance.loadedAds.length}");

      if (_nativeAd != null) {
        // Successfully got an ad
        setState(() {});
      } else {
        // No ad available, retry after a short delay
        _retryTimer = Timer(const Duration(milliseconds: 500), () {
          if (mounted) {
            _tryLoadAd();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "AdSeparatorWidget build: _nativeAd = ${_nativeAd != null ? 'NOT NULL' : 'NULL'}");
    if (_nativeAd != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: NativeAdWidget(nativeAd: _nativeAd!),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ads_click,
              color: Colors.grey.withOpacity(0.5),
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              "Loading Ad...",
              style: TextStyle(
                color: Colors.grey.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
