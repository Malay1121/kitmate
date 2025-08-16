import 'package:kitmate/app/helper/all_imports.dart';

class SubscriptionManager {
  static const entitlementId = 'pro';

  static Future<void> loginRevenueCat() async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      await Purchases.logIn(user!.uid);
    } catch (e) {
      showSnackbar(message: "RevenueCat login failed.");
    }
  }

  static Future<CustomerInfo?> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } catch (e) {
      showSnackbar(message: "Failed to get subscription info.");
      return null;
    }
  }

  static Future<bool> isProUser() async {
    final info = await getCustomerInfo();

    return info?.entitlements.all[entitlementId]?.isActive ?? false;
  }

  static Future<String?> getRevenueCatUserId() async {
    final info = await getCustomerInfo();
    return info?.originalAppUserId;
  }

  static Future<void> syncSubscriptionStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    final info = await getCustomerInfo();

    if (user == null || info == null) return;

    final isPro = info.entitlements.all[entitlementId]?.isActive ?? false;
    final revenuecatUserId = info.originalAppUserId;

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    await userDoc.update({
      "subscription": {
        'plan': isPro ? 'pro' : 'free',
        'entitlementActive': isPro,
        'revenuecatUserId': revenuecatUserId,
        'subscriptionLastChecked': toUtc(DateTime.now()),
      }
    });
  }

  static Future<void> restorePurchases() async {
    try {
      await Purchases.restorePurchases();
      await syncSubscriptionStatus();
    } catch (e) {
      showSnackbar(message: "Restore failed.");
    }
  }

  static Future<void> logOut() async {
    try {
      await Purchases.logOut();
    } catch (e) {
      showSnackbar(message: "RevenueCat logout failed.");
    }
  }

  // static void showPaywall() async {
  //   final paywallResult = await RevenueCatUI.presentPaywall();
  // }
}
