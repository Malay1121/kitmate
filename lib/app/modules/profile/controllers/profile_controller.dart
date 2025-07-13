import 'package:kitmate/app/helper/all_imports.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends CommonController {
  List<Map> settingsOption = [];

  void navigate(String route) {
    Get.toNamed(route);
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    await SubscriptionManager.logOut();
    writeUserDetails({});
    Get.offAllNamed(Routes.SPLASH);
  }

  void initSettings() {
    settingsOption = [
      {
        "title": AppStrings.editProfile,
        "icon": Icons.edit,
        "onTap": () => navigate(Routes.EDIT_PROFILE),
      },
      {
        "title": AppStrings.manageSubscriptions,
        "icon": Icons.paid,
        "onTap": () => navigate(Routes.SUBSCRIPTIONS),
      },
      {
        "title": AppStrings.aboutUs,
        "icon": Icons.people,
        "onTap": () =>
            launchUrl(Uri.parse("https://kitmate-app.web.app/about-us")),
      },
      {
        "title": AppStrings.contactUs,
        "icon": Icons.contact_support,
        "onTap": () =>
            launchUrl(Uri.parse("https://kitmate-app.web.app/contact-us")),
      },
      {
        "title": AppStrings.privacyPolicy,
        "icon": Icons.privacy_tip,
        "onTap": () =>
            launchUrl(Uri.parse("https://kitmate-app.web.app/privacy-policy")),
      },
      {
        "title": AppStrings.termsAndConditions,
        "icon": Icons.book,
        "onTap": () => launchUrl(
            Uri.parse("https://kitmate-app.web.app/terms-and-conditions")),
      },
      {
        "title": AppStrings.logout,
        "icon": Icons.logout,
        "onTap": () => logout(),
      },
      {
        "title": AppStrings.deleteAccount,
        "icon": Icons.delete,
        "onTap": () =>
            launchUrl(Uri.parse("https://kitmate-app.web.app/data-removal")),
      },
    ];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initSettings();
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
