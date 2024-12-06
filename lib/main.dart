import 'package:kitmate/app/helper/all_imports.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBorYbR8bZeFT9exUG8tH5oFPOE-opz4kk",
          appId: "1:964196933360:android:2d10bd046245cf38b1ac35",
          messagingSenderId: "964196933360",
          projectId: "kitmate-app"));
  initializeSize(220, 477);
  configureEasyLoading();

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
