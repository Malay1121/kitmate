import 'package:purchases_ui_flutter/views/paywall_view.dart';

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
          body: !controller.pro
              ? PaywallView(
                  onRestoreCompleted: (CustomerInfo customerInfo) async =>
                      await controller.restorePurchases(),
                  onDismiss: () => Get.back(),
                  onPurchaseCompleted: (customerInfo, storeTransaction) =>
                      controller.purchase(customerInfo),
                  onPurchaseCancelled: () =>
                      showSnackbar(message: "Purchase cancelled by the user"),
                  onPurchaseError: (p0) =>
                      showSnackbar(message: "Purchase failed: ${p0.message}"),
                  onRestoreError: (p0) =>
                      showSnackbar(message: "Restore failed: ${p0.message}"),
                  displayCloseButton: true,
                )
              : Column(
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
                                                  for (Map feature
                                                      in proFeatures)
                                                    Container(
                                                      width: 180.w(context),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        vertical: 2.h(context),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            getKey(
                                                              feature,
                                                              ["icon"],
                                                              Icons
                                                                  .star_outline,
                                                            ),
                                                            color: AppColors
                                                                .lightGrey2,
                                                            size: 12.t(context),
                                                          ),
                                                          SizedBox(
                                                            width: 4.w(context),
                                                          ),
                                                          AppText(
                                                            text: getKey(
                                                                feature,
                                                                ["label"],
                                                                ""),
                                                            width: 176.w(
                                                                    context) -
                                                                12.t(context),
                                                            maxLines: null,
                                                            style:
                                                                Styles.semiBold(
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
                                                    text: AppStrings.goBack,
                                                    onTap: () => Get.back(),
                                                  ),
                                                  SizedBox(
                                                    height: 8.h(context),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => controller
                                                        .restorePurchases(),
                                                    child: AppText(
                                                      text: AppStrings
                                                          .restorePurchases,
                                                      style: Styles.bold(
                                                        fontSize: 8.t(context),
                                                        color:
                                                            AppColors.fontDark,
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
                                                        color:
                                                            AppColors.fontDark,
                                                      ),
                                                    ),
                                                  AppText(
                                                    text: AppStrings
                                                        .termsAndConditions,
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
