import 'package:kitmate/app/helper/all_imports.dart';
import 'package:new_version_plus/new_version_plus.dart';

class SplashController extends AnonCommonController {
  bool firstTime = true;
  bool emailVerified = false;
  bool processesDone = false;
  bool timeDone = false;

  void checkLogin() async {
    try {
      final newVersionPlus = NewVersionPlus();
      final status = await newVersionPlus.getVersionStatus();
      if (status != null && status.canUpdate) {
        newVersionPlus.showUpdateDialog(
            context: Get.context!,
            versionStatus: status,
            dialogTitle: 'New update!',
            dialogText: status.releaseNotes ?? "",
            updateButtonText: 'Update',
            dismissButtonText: 'Close App',
            dismissAction: () => Get.back(),
            allowDismissal: false);
      }
    } catch (e) {
      print(e.toString());
    }
    var userData = readUserDetails();
    if (userData != null && userData != {}) {
      UserCredential? user = await DatabaseHelper.loginUser(data: userData);
      if (user != null) {
        firstTime = false;
        emailVerified = user.user?.emailVerified ?? false;
        if (!emailVerified) {
          await user.user?.sendEmailVerification();
        }
        processesDone = true;
        navigate();
      }
    }
  }

  void navigate() {
    if (processesDone && timeDone) {
      Get.offAndToNamed(!firstTime
          ? emailVerified
              ? Routes.HOME
              : Routes.EMAIL_VERIFICATION
          : Routes.SIGNUP);
    }
  }

  @override
  void onInit() {
    super.onInit();
    try {
      checkLogin();

      DatabaseHelper.getApis();
    } catch (e) {}
    Future.delayed(
      const Duration(seconds: 3),
      () {
        timeDone = true;
        navigate();
      },
    );
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
