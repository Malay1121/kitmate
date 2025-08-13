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
                        : widget.selectedTab == AppStrings.home
                            ? Get.toNamed(tab["page"])
                            : Get.offAndToNamed(tab["page"]),
                child: getKey(tab, ["title"], "") != AppStrings.generate
                    ? Container(
                        height: 40.h(context),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (getKey(tab, ["icon"], null) != null)
                              Icon(
                                tab["title"] == widget.selectedTab
                                    ? tab["selected_icon"]
                                    : tab["icon"],
                                color: tab["title"] == widget.selectedTab
                                    ? AppColors.primary
                                    : AppColors.fontDark,
                                size: 12.t(context),
                              ),
                            if (getKey(tab, ["icon_asset_svg"], null) != null)
                              SvgPicture.asset(
                                getKey(tab, ["icon_asset_svg"], ""),
                                color: tab["title"] == widget.selectedTab
                                    ? AppColors.primary
                                    : AppColors.fontDark,
                                width: 12.t(context),
                                height: 12.t(context),
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
                      )
                    : Container(
                        height: 40.h(context),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w(context), vertical: 5.h(context)),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (getKey(tab, ["icon"], null) != null)
                                    Icon(
                                      tab["icon"],
                                      // color: AppColors.white,
                                      size: 12.t(context),
                                    ),
                                  if (getKey(tab, ["icon_asset_svg"], null) !=
                                      null)
                                    SvgPicture.asset(
                                      getKey(tab, ["icon_asset_svg"], ""),
                                      color: AppColors.white,
                                      width: 12.t(context),
                                      height: 12.t(context),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
