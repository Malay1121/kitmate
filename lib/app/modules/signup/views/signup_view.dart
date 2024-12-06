import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.white,
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 83.h(context),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AppImages.logo,
                      height: 60.h(context),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 32.h(context),
                  ),
                  AppText(
                    text: controller.signup
                        ? AppStrings.createAccount
                        : AppStrings.hiWelcomeBack,
                    style: Styles.semiBold(
                      color: AppColors.primaryText,
                      fontSize: 14.84.t(context),
                    ),
                    width: 342.w(context),
                    height: 30.h(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8.h(context),
                  ),
                  if (controller.signup)
                    CommonTextField(
                      hintText: AppStrings.yourName,
                      controller: controller.nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.5.h(context),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 10.t(context),
                        ),
                      ),
                    ),
                  if (controller.signup)
                    SizedBox(
                      height: 20.h(context),
                    ),
                  CommonTextField(
                    hintText: AppStrings.yourEmail,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.5.h(context),
                      ),
                      child: Icon(
                        Icons.email,
                        size: 10.t(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h(context),
                  ),
                  CommonTextField(
                    hintText: AppStrings.password,
                    controller: controller.passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.5.h(context),
                      ),
                      child: Icon(
                        Icons.lock,
                        size: 10.t(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h(context),
                  ),
                  CommonButton(
                    text: controller.signup
                        ? AppStrings.createAccount
                        : AppStrings.signIn,
                    onTap: () => controller.submit(),
                  ),
                  SizedBox(
                    height: 24.h(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 56.9.w(context),
                        height: 1,
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w(context),
                        ),
                        child: AppText(
                          text: "or",
                          width: 16.w(context),
                          style: Styles.medium(
                            fontSize: 12.t(context),
                            color: AppColors.fontGrey,
                          ),
                        ),
                      ),
                      Container(
                        width: 56.9.w(context),
                        height: 1,
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text:
                            "${controller.signup ? AppStrings.doYouHaveAnAccount : AppStrings.dontHaveAnAccountYet} ",
                        style: Styles.regular(
                          fontSize: 10.t(context),
                          color: AppColors.fontGrey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.switchScreen(),
                        child: AppText(
                          text: controller.signup
                              ? AppStrings.signIn
                              : AppStrings.signUp,
                          style: Styles.regular(
                            fontSize: 10.t(context),
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
