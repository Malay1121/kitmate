import 'package:kitmate/app/helper/all_imports.dart';

class SubscriptionsController extends CommonController {
  Package? selectedPackage;

  List<Package> availablePackages = [];

  Future<void> fetchOfferings() async {
    try {
      EasyLoading.show();
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        availablePackages = offerings.current!.availablePackages;
        update();
      }
      EasyLoading.dismiss();
    } catch (e) {
      showSnackbar(message: "Error fetching offerings: $e");
      EasyLoading.dismiss();
    }
  }

  Future<void> purchase(CustomerInfo customerInfo) async {
    try {
      EasyLoading.show();
      if (customerInfo.entitlements.all["pro"]?.isActive == true) {
        await SubscriptionManager.syncSubscriptionStatus();
        showSnackbar(message: "You've successfully upgraded to Pro!");

        update();
      }
      EasyLoading.dismiss();
    } catch (e) {
      if (e is PurchasesErrorCode &&
          e == PurchasesErrorCode.purchaseCancelledError) {
        // User cancelled
      } else {
        // print("Purchase failed: $e");
      }
      EasyLoading.dismiss();
    }
  }

  Future<void> restorePurchases() async {
    EasyLoading.show();
    await SubscriptionManager.restorePurchases();
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    fetchOfferings();
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
