import 'package:kitmate/app/helper/all_imports.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  if (getStorage.read("loggedin") == true) {
    AppPages.INITIAL = Routes.HOME;
  }

  initializeSize(220, 477);
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      alignment: Alignment.center,
      child: AppText(
        text: 'Error!\n${details.exception}',
        style: TextStyle(color: AppColors.fontDark),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      ),
    );
  };
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      builder: EasyLoading.init(),
      getPages: AppPages.routes,
    ),
  );
}
