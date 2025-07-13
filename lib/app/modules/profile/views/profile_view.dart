import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.lightBG,
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h(context),
                          horizontal: 20.w(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45.w(context),
                                  height: 45.h(context),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        getKey(
                                                    userDetails,
                                                    ["subscription", "plan"],
                                                    "free") ==
                                                "pro"
                                            ? AppImages.icProBadge
                                            : AppImages.icFreeBadge,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: greet(),
                                      style: Styles.medium(
                                        color: AppColors.fontGrey,
                                        fontSize: 12.t(context),
                                      ),
                                      height: 16.h(context),
                                    ),
                                    AppText(
                                      text: getKey(userDetails, ["name"], ""),
                                      style: Styles.medium(
                                        color: AppColors.fontDark,
                                        fontSize: 16.t(context),
                                      ),
                                      height: 21.h(context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h(context),
                            ),
                            for (Map setting in controller.settingsOption)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10.h(context),
                                  ),
                                  GestureDetector(
                                    onTap: setting["onTap"],
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: AppColors.primary,
                                            ),
                                            width: 26.w(context),
                                            height: 26.h(context),
                                            child: Icon(
                                              setting["icon"],
                                              size: 14.t(context),
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w(context),
                                        ),
                                        AppText(
                                          text: setting["title"],
                                          style: Styles.bold(
                                            color: AppColors.fontDark,
                                            fontSize: 9.t(context),
                                          ),
                                          width: 120.w(context),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.navigate_next,
                                          color: AppColors.fontDark,
                                          size: 14.t(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h(context),
                                  ),
                                  Container(
                                    width: 390.w(context),
                                    height: 1,
                                    color: AppColors.stroke,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CommonBottomBar(
                    selectedTab: AppStrings.profile,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
