import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/email_verification_controller.dart';

class EmailVerificationView extends GetView<EmailVerificationController> {
  const EmailVerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailVerificationController>(
      init: EmailVerificationController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 35.h(context)),
                  // CommonImage(
                  //   imageUrl: AppImages.checkMail,
                  //   fit: BoxFit.fitWidth,
                  //   width: 266.w(context),
                  //   height: 200.h(context),
                  //   type: "asset",
                  // ),
                  SizedBox(height: 40.h(context)),
                  Center(
                    child: AppText(
                      text: 'Check your Email',
                      style: Styles.bold(
                        fontSize: 12.t(context),
                        color: AppColors.fontDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 32.h(context)),
                  Center(
                    child: AppText(
                      text:
                          'We have sent you an Email on ${controller.user?.email}, check your spam/bin if not visible on main inbox',
                      textAlign: TextAlign.center,
                      maxLines: null,
                      width: 250.w(context),
                      style: Styles.regular(
                        fontSize: 9.t(context),
                        color: AppColors.fontGrey,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h(context)),
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h(context)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Center(
                      child: AppText(
                        text: 'Verifying email....',
                        style: Styles.semiBold(
                          fontSize: 10.t(context),
                          color: AppColors.fontDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Spacer(),
                  CommonButton(
                    text: "Resend",
                    onTap: () {
                      try {
                        controller.user?.sendEmailVerification();
                      } catch (e) {
                        debugPrint('$e');
                      }
                    },
                  ),
                  SizedBox(height: 32.h(context)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
