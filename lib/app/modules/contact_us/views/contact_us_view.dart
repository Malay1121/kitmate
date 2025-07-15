import 'package:firebase_pagination/firebase_pagination.dart';

import '../../../helper/all_imports.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
      init: ContactUsController(),
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
                        text: AppStrings.tickets,
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
                    height: 20.h(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          FirestorePagination(
                            query: FirebaseFirestore.instance
                                .collection("tickets")
                                .where("user",
                                    isEqualTo: controller.user?.uid ?? "")
                                .orderBy("updated_at"),
                            shrinkWrap: true,
                            isLive: true,
                            itemBuilder: (context, items, index) {
                              if (items.isEmpty) {
                                return SizedBox();
                              }
                              Map ticket = items[index].data() as Map;
                              return GestureDetector(
                                onTap: () => Get.toNamed(
                                  Routes.TICKET,
                                  arguments: {
                                    "ticket": getKey(ticket, ["id"], ""),
                                  },
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 11.w(context),
                                    vertical: 11.h(context),
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: 11.h(context),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.cardColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: 196.w(context),
                                  child: Row(
                                    children: [
                                      if (!getKey(ticket, ["seen"], true))
                                        Container(
                                          width: 5.w(context),
                                          height: 5.h(context),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      if (!getKey(ticket, ["seen"], true))
                                        SizedBox(
                                          width: 5.w(context),
                                        ),
                                      AppText(
                                        text: getKey(ticket, ["message"], ""),
                                        style: Styles.medium(
                                          fontSize: 9.t(context),
                                          color: AppColors.fontDark,
                                        ),
                                        width: 150.w(context) - 10.t(context),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        minFontSize:
                                            9.t(context).floorToDouble(),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 10.t(context),
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  CommonButton(
                    text: AppStrings.createTicket,
                    onTap: () =>
                        Get.toNamed(Routes.TICKET, arguments: {"id": null}),
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
