import 'package:kitmate/app/helper/all_imports.dart';

class TicketController extends CommonController {
  String? ticketId;
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    EasyLoading.show();
    if (ticketId != null) {
      await DatabaseHelper.replyTicket(
        userId: user?.uid ?? "",
        ticketId: ticketId!,
        message: messageController.text,
      );
      messageController.text = "";
    } else {
      Map? result = await DatabaseHelper.createTicket(
          userId: user?.uid ?? "", message: messageController.text);
      if (result != null) {
        ticketId = getKey(result, ["ticket"], null);
      }
      messageController.text = "";
      update();
    }
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      ticketId = Get.arguments["ticket"];
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
