import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
        init: OnboardingController(),
        builder: (controller) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35.h(context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w(context),
                  ),
                  child: Row(
                    children: [
                      for (Map<String, dynamic> page in controller.data)
                        Container(
                          margin: EdgeInsets.only(
                            right: 2.52.w(context),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: controller.data.indexOf(page) ==
                                      controller.currentPage
                                  ? Colors.transparent
                                  : AppColors.black,
                              width: 0.53,
                            ),
                            color: controller.data.indexOf(page) ==
                                    controller.currentPage
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                          height: 13.77.h(context),
                          width: 13.77.w(context),
                          child: Center(
                            child: AppText(
                              text: (controller.data.indexOf(page) + 1)
                                  .toString(),
                              centered: true,
                              style: Styles.regular(
                                color: controller.data.indexOf(page) ==
                                        controller.currentPage
                                    ? AppColors.white
                                    : AppColors.fontDark,
                                fontSize: 7.42.t(context),
                              ),
                            ),
                          ),
                        ),
                      Spacer(),
                      AppText(
                        text: AppStrings.skip,
                        style: Styles.bold(
                          color: AppColors.blue,
                          fontSize: 9.57.t(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 11.w(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 21.h(context),
                          ),
                          AppText(
                            text: controller.data[controller.currentPage]
                                ["title"],
                            maxLines: 2,
                            width: 160.w(context),
                            style: Styles.semiBold(
                              fontSize: 15.55.t(context),
                              color: AppColors.fontDark,
                            ),
                          ),
                          SizedBox(
                            height: 11.54.h(context),
                          ),
                          AppText(
                            text: AppStrings.toOfferYouBestTailoredDiet,
                            maxLines: null,
                            width: 160.w(context),
                            style: Styles.regular(
                              fontSize: 9.t(context),
                              color: AppColors.fontGrey,
                            ),
                          ),
                          SizedBox(
                            height: 22.h(context),
                          ),
                          Wrap(
                            spacing: 6.w(context),
                            runSpacing: 9.h(context),
                            children: [
                              for (Map option in controller
                                  .data[controller.currentPage]["options"]
                                  .where((e) => e["custom"] != true))
                                GestureDetector(
                                  onTap: () => controller.toggleOption(option),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 11.w(context),
                                      vertical: 2.h(context),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.52),
                                      border: Border.all(
                                        color: option["selected"]
                                            ? Colors.transparent
                                            : AppColors.black,
                                      ),
                                      color: option["selected"]
                                          ? AppColors.primary
                                          : Colors.transparent,
                                    ),
                                    child: AppText(
                                      text: option["label"],
                                      style: Styles.regular(
                                        color: option["selected"]
                                            ? AppColors.white
                                            : AppColors.fontDark,
                                        fontSize: 9.53.t(context),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h(context),
                          ),
                          Container(
                            width: 196.w(context),
                            decoration: BoxDecoration(
                              color: AppColors.cardColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h(context),
                                horizontal: 10.w(context),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w(context),
                                    child: Wrap(
                                      runSpacing: 10.h(context),
                                      spacing: 10.w(context),
                                      children: [
                                        if (controller
                                            .data[controller.currentPage]
                                                ["options"]
                                            .where(
                                              (e) => e["custom"] == true,
                                            )
                                            .isEmpty)
                                          AppText(
                                            text: controller.data[controller
                                                .currentPage]["record"],
                                            maxLines: null,
                                            width: 150.w(context),
                                            style: Styles.semiBold(
                                              fontSize: 14,
                                              color: AppColors.fontGrey,
                                            ),
                                          ),
                                        for (var option in controller
                                            .data[controller.currentPage]
                                                ["options"]
                                            .where(
                                          (e) => e["custom"] == true,
                                        ))
                                          GestureDetector(
                                            onTap: () =>
                                                controller.deleteOption(option),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: option["selected"]
                                                    ? AppColors.primary
                                                    : AppColors.fontGrey,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 2.h(context),
                                                  horizontal: 11.w(context),
                                                ),
                                                child: AppText(
                                                  text: option["label"],
                                                  style: Styles.semiBold(
                                                      color: option["selected"]
                                                          ? AppColors.white
                                                          : AppColors.fontGrey,
                                                      fontSize:
                                                          9.53.t(context)),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (!controller.listening) {
                                        try {
                                          controller.getText();
                                        } catch (e) {
                                          controller.listening = false;
                                          controller.update();
                                          EasyLoading.dismiss();
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 20.h(context),
                                      width: 20.w(context),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primary,
                                      ),
                                      child: Icon(
                                        controller.listening
                                            ? Icons.stop
                                            : Icons.mic,
                                        size: 10.t(context),
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.currentPage != 0)
                      CommonButton(
                        text: AppStrings.previous,
                        width: 80,
                        backgroundColor: AppColors.cardColor,
                        textColor: AppColors.fontDark,
                        onTap: () => controller.navigate(false),
                      ),
                    if (controller.currentPage != 0)
                      SizedBox(
                        width: 36.w(context),
                      ),
                    CommonButton(
                      text: AppStrings.next,
                      width: controller.currentPage != 0 ? 80 : 196,
                      onTap: () => controller.navigate(true),
                    ),
                  ],
                ),
                SizedBox(
                  height: 37.h(context),
                ),
              ],
            ),
          );
        });
  }
}
