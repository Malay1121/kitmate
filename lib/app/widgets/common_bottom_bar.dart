import 'package:kitmate/app/helper/all_imports.dart';

class CommonBottomBar extends StatefulWidget {
  CommonBottomBar({
    super.key,
    required this.selectedTab,
  });
  String selectedTab;
  @override
  State<CommonBottomBar> createState() => _CommonBottomBarState();
}

class _CommonBottomBarState extends State<CommonBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w(context),
      height: 40.h(context),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
          ),
        ],
      ),
      child: Row(
        children: [
          for (Map tab in tabs)
            Expanded(
              child: GestureDetector(
                onTap: () => tab["title"] == widget.selectedTab
                    ? null
                    : tab["page"] == Routes.HOME
                        ? Get.back()
                        : widget.selectedTab == AppStrings.mealPlans
                            ? Get.toNamed(tab["page"])
                            : Get.offAndToNamed(tab["page"]),
                child: Container(
                  height: 40.h(context),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tab["icon"],
                        color: tab["title"] == widget.selectedTab
                            ? AppColors.primary
                            : AppColors.fontDark,
                        size: 12.t(context),
                      ),
                      if (tab["title"] == widget.selectedTab)
                        AppText(
                          text: tab["title"],
                          height: 12.h(context),
                          centered: true,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: SfProDisplay,
                            fontWeight: FontWeight.w500,
                            fontSize: 8.t(context),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
