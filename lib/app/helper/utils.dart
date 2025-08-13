import 'package:http/http.dart' as http;

import 'all_imports.dart';

GetStorage getStorage = GetStorage();

List<Map> tabs = [
  {
    "title": AppStrings.home,
    "icon": Icons.home_outlined,
    "selected_icon": Icons.home_rounded,
    "page": Routes.HOME,
  },
  {
    "title": AppStrings.saved,
    "icon": Icons.favorite_border,
    "selected_icon": Icons.favorite_rounded,
    "page": Routes.SAVED_RECIPES,
  },
  {
    "title": AppStrings.generate,
    "icon_asset_svg": AppImages.icWand,
    "page": Routes.GENERATE_RECIPE,
  },
  {
    "title": AppStrings.storage,
    "icon": Icons.storage_outlined,
    "selected_icon": Icons.storage_rounded,
    "page": Routes.INGREDIENTS,
  },
  {
    "title": AppStrings.profile,
    "icon": Icons.person_outline_rounded,
    "selected_icon": Icons.person_rounded,
    "page": Routes.PROFILE,
  },
];

Map freeLimitations = {
  "max_ingredients": 30,
  "max_recipes": 3,
  "ingredients_from_speech": 3
};

List proFeatures = [
  {
    "label": AppStrings.unlimitedIngredients,
    "icon": Icons.inventory_2_outlined,
  },
  {
    "label": AppStrings.unlimitedRecipes,
    "icon": Icons.menu_book_outlined,
  },
  {
    "label": AppStrings.unlimitedSpeechFeatures,
    "icon": Icons.mic_none_outlined,
  },
  {
    "label": AppStrings.accessToCustomMessage,
    "icon": Icons.message_outlined,
  },
  {
    "label": AppStrings.accessToServings,
    "icon": Icons.dining_outlined,
  },
];

Map apiKeys = {
  "gemini": {
    "apis": [],
    "index": 0,
  },
  "unsplash": {
    "apis": [],
    "index": 0,
  },
};

dynamic getKey(Map data, List location, dynamic replacement) {
  dynamic value = data;
  for (var key in location) {
    if (value is Map) {
      value = value[key];
    } else {
      return replacement;
    }
  }
  return value ?? replacement;
}

String getApi(String api) {
  return apiKeys[api]["apis"][apiKeys[api]["index"]];
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String generateFromMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

bool validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool validatePassword(String password) {
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
      .hasMatch(password);
}

bool validatePhone(String phone) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);
  if (isEmptyString(phone)) {
    return false;
  } else if (!regExp.hasMatch(phone)) {
    return false;
  }
  return true;
}

bool isEmptyString(String? string) {
  if (string == null || string.isEmpty) {
    return true;
  }
  return false;
}

void configureEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorColor = AppColors.primary
    ..loadingStyle = EasyLoadingStyle.dark
    ..userInteractions = false
    ..dismissOnTap = false;
}

String greet() {
  DateTime now = DateTime.now();
  int hours = now.hour;
  String greeting = "";

  if (hours >= 1 && hours <= 12) {
    greeting = "Good Morning";
  } else if (hours >= 12 && hours <= 16) {
    greeting = "Good Afternoon";
  } else if (hours >= 16 && hours <= 21) {
    greeting = "Good Evening";
  } else if (hours >= 21 && hours <= 24) {
    greeting = "Good Night";
  }
  return greeting;
}

void logout() {
  getStorage.erase();
  FirebaseAuth.instance.signOut();
  Get.offAllNamed(Routes.SIGNUP);
}

void writeUserDetails(Map<String, dynamic> data) {
  // print(data);
  getStorage.write("userDetails", data);
  // print(readUserDetails());
}

Map<String, dynamic>? readUserDetails() {
  return getStorage.read("userDetails");
}

showSnackbar({String? title, String? message}) {
  Get.snackbar(
    title ?? 'Kitmate',
    message ?? '',
    backgroundColor: AppColors.primary,
    colorText: AppColors.white,
  );
}

DateTime fromUtc(String dateTime) {
  return DateTime.parse(dateTime).toLocal();
}

String toUtc(DateTime dateTime) {
  return dateTime.toUtc().toString();
}

Future textToSpeech(String text) async {
  FlutterTts flutterTts = FlutterTts();
  await flutterTts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.ambient,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers
      ],
      IosTextToSpeechAudioMode.voicePrompt);
  await flutterTts.awaitSpeakCompletion(true);
  await flutterTts.speak(text);
}

void editUserDetails(Map<String, dynamic> data) {
  Map userDetails = getStorage.read("userDetails");
  for (var key in data.keys) {
    if (userDetails[key] == null) {
      userDetails.addEntries({key: data[key]}.entries);
    } else {
      userDetails[key] = data[key];
    }
  }
  getStorage.write("userDetails", data);
}

String getMessageFromErrorCode(e) {
  // print(e.code);
  // print(e.message);
  switch (e.code) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
      break;
    case "channel-error":
      return "Unable to establish connection on channel. Please try again later";
      break;
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
      break;
    default:
      return "Login failed. Please try again.";
      break;
  }
}

void showFirebaseError(error) {
  Get.snackbar(AppStrings.appName, error);
}

String idToString(String id) {
  return id.replaceAll("_", " ").capitalizeFirst ?? id;
}

run(VoidCallback task) async {
  try {
    task();
  } catch (e, stack) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Text('Oops!'),
        backgroundColor: AppColors.white,
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> getImage(String query) async {
  var request = await http.get(Uri.parse(
      'https://api.unsplash.com/search/photos?query=$query&client_id=i7Jw5ebxgDS8oq44B4Is2QtDa4iAkWAW2WhAjmhTdgA'));

  String response = request.body;

  if (request.statusCode == 200) {
    return jsonDecode(response)["results"][0]["urls"]["raw"];
  } else {
    print(request.reasonPhrase);
  }
  return "";
}

void proPopup() async {
  if (!(await SubscriptionManager.isProUser())) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: StatefulBuilder(builder: (context, setState) {
          return Container(
            // height: 320.h(Get.context!),
            width: 196.w(Get.context!),
            constraints: BoxConstraints(
                // maxHeight: 400.h(Get.context!),
                ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 11.w(Get.context!), vertical: 11.h(Get.context!)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: AppStrings.proPlanRequired,
                    style: Styles.semiBold(
                      color: AppColors.fontDark,
                      fontSize: 13.t(context),
                    ),
                    maxLines: 2,
                    width: 150.w(context),
                    centered: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.h(context),
                  ),
                  AppText(
                    text: AppStrings.upgradeYourAccountForFullAccess,
                    style: Styles.medium(
                      color: AppColors.fontGrey,
                      fontSize: 9.5.t(context),
                    ),
                    maxLines: 2,
                    width: 150.w(context),
                    centered: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.h(context),
                  ),
                  for (Map feature in proFeatures)
                    Container(
                      width: 180.w(context),
                      margin: EdgeInsets.symmetric(
                        vertical: 2.h(context),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            getKey(
                              feature,
                              ["icon"],
                              Icons.star_outline,
                            ),
                            color: AppColors.lightGrey2,
                            size: 10.t(context),
                          ),
                          SizedBox(
                            width: 4.w(context),
                          ),
                          AppText(
                            text: getKey(feature, ["label"], ""),
                            width: 165.w(context) - 12.t(context),
                            maxLines: null,
                            style: Styles.regular(
                              color: AppColors.fontDark,
                              fontSize: 9.t(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 20.h(context),
                  ),
                  CommonButton(
                    text: AppStrings.upgrade,
                    onTap: () => Get.toNamed(Routes.SUBSCRIPTIONS),
                  ),
                  SizedBox(
                    height: 5.h(context),
                  ),
                  CommonButton(
                    text: AppStrings.cancel,
                    textColor: AppColors.fontDark,
                    backgroundColor: Colors.transparent,
                    onTap: () => Get.back(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Future<Map<String, dynamic>> fetchDetailsAuto(
//     String text, List parameters) async {
//   String bodyEncoded = json.encode({
//     "system_instruction": {
//       "parts": [
//         {
//           "text": AppStrings.autoFillPrompt,
//         }
//       ]
//     },
//     "contents": [
//       {
//         "parts": [
//           {
//             "text": jsonEncode({
//               "text": text,
//               "parameters": parameters,
//             }),
//           }
//         ]
//       }
//     ],
//     "generationConfig": {"response_mime_type": "application/json"}
//   });
//   // print(bodyEncoded);
//   var headers = {'Content-Type': 'application/json'};
//   var request = await http.post(
//     Uri.parse(
//         'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=${apiKeys["gemini"]}'),
//     headers: headers,
//     body: bodyEncoded,
//   );
//
//   if (request.statusCode == 200) {
//     String response = request.body;
//     print(response);
//     return json.decode(response);
//   } else {
//     // print(request.statusCode);
//     return {};
//   }
// }
