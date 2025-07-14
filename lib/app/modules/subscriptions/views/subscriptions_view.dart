import '../../../helper/all_imports.dart';
import '../controllers/subscriptions_controller.dart';

class SubscriptionsView extends GetView<SubscriptionsController> {
  const SubscriptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionsController>(
      init: SubscriptionsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.asset(
                            AppImages.subscriptionPageImage,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.cardColor,
                                width: 220.w(context),
                                height: 186.h(context),
                                child: Icon(Icons.image),
                              );
                            },
                            fit: BoxFit.cover,
                            width: 220.w(context),
                            height: 186.h(context),
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 127.5.h(context),
                                      ),
                                      Container(
                                        width: 220.w(context),
                                        constraints: BoxConstraints(
                                          minHeight: 349.h(context),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(28),
                                            topLeft: Radius.circular(28),
                                          ),
                                          color: AppColors.white,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 7.5.w(context),
                                          vertical: 18.h(context),
                                        ),
                                        child: Column(
                                          children: [
                                            AppText(
                                              text: AppStrings
                                                  .yourPersonalPlanIsReady,
                                              style: Styles.semiBold(
                                                color: AppColors.fontDark,
                                                fontSize: 14.t(context),
                                              ),
                                              maxLines: 2,
                                              width: 102.w(context),
                                              centered: true,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 12.5.h(context),
                                            ),
                                            AppText(
                                              text: controller.pro
                                                  ? AppStrings
                                                      .youHaveAlreadySubscribedToPro
                                                  : AppStrings
                                                      .upgradeYourAccountForFullAccess,
                                              style: Styles.medium(
                                                color: AppColors.fontGrey,
                                                fontSize: 9.5.t(context),
                                              ),
                                              maxLines: 2,
                                              width: 150.w(context),
                                              centered: true,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 26.5.h(context),
                                            ),
                                            if (!controller.pro)
                                              for (Package package in controller
                                                  .availablePackages)
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.selectedPackage =
                                                        package;
                                                    controller.update();
                                                  },
                                                  child: Container(
                                                    width: 204.5.w(context),
                                                    height: 41.5.h(context),
                                                    margin: EdgeInsets.only(
                                                      bottom: 10.5.h(context),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.cardColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: controller
                                                                  .selectedPackage ==
                                                              package
                                                          ? Border.all(
                                                              color: AppColors
                                                                  .primary,
                                                              width: 1.5)
                                                          : null,
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          9.5.w(context),
                                                      vertical: 8.h(context),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 10.w(context),
                                                          height: 10.h(context),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                AppColors.white,
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                1.5.w(context),
                                                            vertical:
                                                                1.5.h(context),
                                                          ),
                                                          child: controller
                                                                      .selectedPackage ==
                                                                  package
                                                              ? Container(
                                                                  width: 7.w(
                                                                      context),
                                                                  height: 7.h(
                                                                      context),
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .primary,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                )
                                                              : SizedBox(),
                                                        ),
                                                        SizedBox(
                                                          width: 8.w(context),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AppText(
                                                              text: package
                                                                  .storeProduct
                                                                  .title
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r' \([^)]*\)\)'),
                                                                      ''),
                                                              style: Styles
                                                                  .semiBold(
                                                                color: AppColors
                                                                    .fontDark,
                                                                fontSize: 12
                                                                    .t(context),
                                                              ),
                                                              maxLines: 1,
                                                              height:
                                                                  15.h(context),
                                                              width: 75.5
                                                                  .w(context),
                                                            ),
                                                            AppText(
                                                              text: package
                                                                  .storeProduct
                                                                  .description,
                                                              style: Styles
                                                                  .regular(
                                                                color: AppColors
                                                                    .fontDark,
                                                                fontSize: 6
                                                                    .t(context),
                                                              ),
                                                              height: 8.5
                                                                  .h(context),
                                                              maxLines: 1,
                                                              width:
                                                                  85.w(context),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 1.w(context),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            AppRichText(
                                                              width:
                                                                  76.w(context),
                                                              textAlign:
                                                                  TextAlign.end,
                                                              text: TextSpan(
                                                                  text: package
                                                                      .storeProduct
                                                                      .currencyCode,
                                                                  children: [
                                                                    TextSpan(
                                                                      text: package.storeProduct.subscriptionPeriod ==
                                                                              "P1Y"
                                                                          ? (package.storeProduct.price / 12)
                                                                              .toString()
                                                                          : package
                                                                              .storeProduct
                                                                              .priceString,
                                                                      style: Styles
                                                                          .semiBold(
                                                                        color: AppColors
                                                                            .fontDark,
                                                                        fontSize:
                                                                            14.t(context),
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          "/ month",
                                                                      style: Styles
                                                                          .regular(
                                                                        color: AppColors
                                                                            .fontDark,
                                                                        fontSize:
                                                                            7.t(context),
                                                                      ),
                                                                    ),
                                                                  ]),
                                                              style: TextStyle(
                                                                fontSize: 9
                                                                    .t(context),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            if (controller.pro)
                                              for (Map feature in proFeatures)
                                                Container(
                                                  width: 180.w(context),
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 2.h(context),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        getKey(
                                                          feature,
                                                          ["icon"],
                                                          Icons.star_outline,
                                                        ),
                                                        color: AppColors
                                                            .lightGrey2,
                                                        size: 12.t(context),
                                                      ),
                                                      SizedBox(
                                                        width: 4.w(context),
                                                      ),
                                                      AppText(
                                                        text: getKey(feature,
                                                            ["label"], ""),
                                                        width: 176.w(context) -
                                                            12.t(context),
                                                        maxLines: null,
                                                        style: Styles.semiBold(
                                                          color: AppColors
                                                              .fontDark,
                                                          fontSize:
                                                              9.t(context),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            SizedBox(
                                              height: 20.h(context),
                                            ),
                                            CommonButton(
                                              text: controller.pro
                                                  ? AppStrings.goBack
                                                  : AppStrings.upgrade,
                                              onTap: () => controller.pro
                                                  ? Get.back()
                                                  : controller.purchase(
                                                      controller
                                                          .selectedPackage),
                                            ),
                                            SizedBox(
                                              height: 8.h(context),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.restorePurchases(),
                                              child: AppText(
                                                text:
                                                    AppStrings.restorePurchases,
                                                style: Styles.bold(
                                                  fontSize: 8.t(context),
                                                  color: AppColors.fontDark,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8.h(context),
                                            ),
                                            if (!controller.pro)
                                              AppText(
                                                text: AppStrings
                                                    .byContinuingYouAgreeToThe,
                                                style: Styles.regular(
                                                  fontSize: 8.t(context),
                                                  color: AppColors.fontDark,
                                                ),
                                              ),
                                            AppText(
                                              text:
                                                  AppStrings.termsAndConditions,
                                              style: Styles.bold(
                                                fontSize: 8.t(context),
                                                color: AppColors.fontDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 20.h(context),
                            left: 15.w(context),
                            child: GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                width: 30.w(context),
                                height: 30.h(context),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: AppColors.black,
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
            ],
          ),
        );
      },
    );
  }
}
