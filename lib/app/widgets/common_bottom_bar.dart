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
      width: 390.w(context),
      height: 65.h(context),
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
                onTap: () => Get.toNamed(tab["page"]),
                child: Container(
                  height: 65.h(context),
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
                        size: 24.t(context),
                      ),
                      if (tab["title"] == widget.selectedTab)
                        AppText(
                          text: tab["title"],
                          height: 24.h(context),
                          centered: true,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: SfProDisplay,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.t(context),
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
