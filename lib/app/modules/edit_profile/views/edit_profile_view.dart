import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w(context)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.black,
                          size: 14.t(context),
                        ),
                      ),
                      AppText(
                        text: AppStrings.editProfile,
                        style: Styles.bold(
                          fontSize: 12.t(context),
                          color: AppColors.fontDark,
                        ),
                      ),
                      SizedBox(
                        width: 14.t(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          CommonTextField(
                            hintText: AppStrings.yourName,
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 6.5.h(context),
                              ),
                              child: Icon(
                                Icons.person,
                                size: 10.t(context),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h(context),
                          ),
                          for (Map card in controller.data)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: getKey(card, ["title"], ""),
                                  style: Styles.semiBold(
                                    color: AppColors.fontDark,
                                    fontSize: 9.t(context),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h(context),
                                ),
                                Container(
                                  width: 196.w(context),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: 16.h(context),
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
                                              if (card["selected"].isEmpty)
                                                AppText(
                                                  text: card["record"],
                                                  maxLines: null,
                                                  width: 150.w(context),
                                                  style: Styles.semiBold(
                                                    fontSize: 14,
                                                    color: AppColors.fontGrey,
                                                  ),
                                                ),
                                              for (var option
                                                  in card["selected"])
                                                GestureDetector(
                                                  onTap: () =>
                                                      controller.deleteOption(
                                                          option,
                                                          controller.data
                                                              .indexOf(card)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: option["selected"]
                                                          ? AppColors.primary
                                                          : AppColors.fontGrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 2.h(context),
                                                        horizontal:
                                                            11.w(context),
                                                      ),
                                                      child: AppText(
                                                        text: option["label"],
                                                        style: Styles.semiBold(
                                                            color: option[
                                                                    "selected"]
                                                                ? AppColors
                                                                    .white
                                                                : AppColors
                                                                    .fontGrey,
                                                            fontSize: 9.53
                                                                .t(context)),
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
                                                controller.getText(controller
                                                    .data
                                                    .indexOf(card));
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
                        ],
                      ),
                    ),
                  ),
                  CommonButton(
                    text: AppStrings.save,
                    onTap: () => controller.updateProfile(),
                  ),
                  SizedBox(
                    height: 10.h(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
