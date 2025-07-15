import 'package:firebase_pagination/firebase_pagination.dart';

import '../../../helper/all_imports.dart';
import '../controllers/ticket_controller.dart';

class TicketView extends GetView<TicketController> {
  const TicketView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketController>(
      init: TicketController(),
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
                        text: AppStrings.ticket,
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
                          !isEmptyString(controller.ticketId)
                              ? FirestorePagination(
                                  query: FirebaseFirestore.instance
                                      .collection("tickets")
                                      .doc(controller.ticketId)
                                      .collection("chat")
                                      .orderBy("created_at", descending: true),
                                  isLive: true,
                                  shrinkWrap: true,
                                  itemBuilder: (context, items, index) {
                                    if (items.isEmpty) {
                                      return SizedBox();
                                    }
                                    controller.messages = items;
                                    Map chat = items[index].data() as Map;
                                    bool owner = getKey(chat, ["user"], null) ==
                                        (controller.user?.uid ?? "");
                                    return Row(
                                      mainAxisAlignment: owner
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 145.w(context),
                                          ),
                                          margin: EdgeInsets.only(
                                            bottom: 1.h(context),
                                          ),
                                          decoration: BoxDecoration(
                                            color: owner
                                                ? AppColors.primary
                                                : AppColors.cardColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomRight: owner
                                                  ? Radius.zero
                                                  : Radius.circular(8),
                                              bottomLeft: !owner
                                                  ? Radius.zero
                                                  : Radius.circular(8),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 7.5.w(context),
                                            vertical: 3.5.h(context),
                                          ),
                                          child: AppText(
                                            text: getKey(chat, ["message"], ""),
                                            maxLines: null,
                                            style: Styles.regular(
                                              fontSize: 7.t(context),
                                              color: owner
                                                  ? AppColors.white
                                                  : AppColors.fontDark,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: 36.5.h(context),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => print(controller.ticketId),
                                    child: AppText(
                                      text: AppStrings
                                          .createTicketByExplainingIssueAndSendingTheMessage,
                                      maxLines: null,
                                      centered: true,
                                      textAlign: TextAlign.center,
                                      style: Styles.semiBold(
                                        fontSize: 9.t(context),
                                        color: AppColors.fontDark,
                                      ),
                                    ),
                                  ),
                                ),
                          if (controller.messages.isNotEmpty &&
                              getKey(controller.messages.last, ["user"],
                                      null) !=
                                  (controller.user?.uid ?? null))
                            AppText(
                                text:
                                    "We have received your message, You will get a reply soon!"),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150.w(context),
                        child: CommonTextField(
                          hintText: AppStrings.writeMessage,
                          controller: controller.messageController,
                        ),
                      ),
                      SizedBox(
                        width: 5.w(context),
                      ),
                      CommonButton(
                        text: AppStrings.send,
                        onTap: () => controller.sendMessage(),
                        width: 35.w(context),
                      ),
                    ],
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
