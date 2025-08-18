import 'package:kitmate/app/helper/all_imports.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends CommonController {
  List<Map> settingsOption = [];

  void navigate(String route) {
    Get.toNamed(route);
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
        "onTap": () => launchUrl(Uri.parse("https://kitmate.app/about-us")),
      },
      {
        "title": AppStrings.contactUs,
        "icon": Icons.contact_support,
        "onTap": () => navigate(Routes.CONTACT_US),
      },
      {
        "title": AppStrings.privacyPolicy,
        "icon": Icons.privacy_tip,
        "onTap": () =>
            launchUrl(Uri.parse("https://kitmate.app/privacy-policy.html")),
      },
      {
        "title": AppStrings.termsAndConditions,
        "icon": Icons.book,
        "onTap": () => launchUrl(
            Uri.parse("https://kitmate.app/terms-and-conditions.html")),
      },
      {
        "title": AppStrings.logout,
        "icon": Icons.logout,
        "onTap": () => logout(),
      },
      {
        "title": AppStrings.deleteAccount,
        "icon": Icons.delete,
        "onTap": () => launchUrl(Uri.parse("https://kitmate.app/account")),
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
