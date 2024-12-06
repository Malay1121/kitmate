import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kitmate/app/helper/all_imports.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: Image.asset(
                AppImages.logo,
                fit: BoxFit.fitWidth,
                width: 150.w(context),
                height: 150.h(context),
              ),
            ),
          );
        });
  }
}
