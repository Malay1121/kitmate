import 'package:kitmate/app/helper/all_imports.dart';

class SplashController extends AnonCommonController {
  bool firstTime = true;
  bool emailVerified = false;

  void checkLogin() async {
    var userData = readUserDetails();
    // print(userData);
    if (userData != null && userData != {}) {
      UserCredential? user = await DatabaseHelper.loginUser(data: userData);
      // print(user);
      if (user != null) {
        firstTime = false;
        emailVerified = user.user?.emailVerified ?? false;
        if (!emailVerified) {
          await user.user?.sendEmailVerification();
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkLogin();
    DatabaseHelper.getApis();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAndToNamed(!firstTime
            ? emailVerified
                ? Routes.HOME
                : Routes.EMAIL_VERIFICATION
            : Routes.SIGNUP);
      },
    );
  }

  @override
  void onReady() {
    // print("xD " + readUserDetails().toString());
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
