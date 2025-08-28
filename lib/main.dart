import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kitmate/app/helper/all_imports.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load();

  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await Purchases.configure(
    PurchasesConfiguration(dotenv.env['revenuecat'] ?? ""),
  );

  apiKeys = {
    "gemini": {
      "apis": [dotenv.env['gemini']],
      "index": 0,
    },
    "unsplash": {
      "apis": [dotenv.env['unsplash']],
      "index": 0,
    },
  };
  MobileAds.instance.initialize();
  AdMobManager.initialize();

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
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(
    GetMaterialApp(
      title: "Kitmate",
      initialRoute: AppPages.INITIAL,
      builder: EasyLoading.init(),
      getPages: AppPages.routes,
    ),
  );
}
