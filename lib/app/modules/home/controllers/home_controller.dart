import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';
import 'package:kitmate/app/modules/home/views/settings_view.dart';

class HomeController extends CommonController {
  Map? recipe;
  Map settings = {
    "consider_current_time": true,
    "consider_allergies": true,
    "consider_diet": true,
    "allow_flexibility": false,
    "time_limit": "",
    "custom_message": "",
    "servings": "",
  };

  void generateRecipe() async {
    EasyLoading.show();
    print({
      "preferences": userDetails["preferences"],
      "ingredients": ingredients,
      "settings": settings,
      "current_time":
          "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}",
    });
    if (ingredients.length >= 5) {
      Map geminiResult =
          await GeminiHelper.fetch(systemPrompt: AppStrings.dishPrompt, data: {
        "preferences": userDetails["preferences"],
        "ingredients": ingredients,
        "settings": settings,
        "current_time":
            "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}",
      });

      if (geminiResult["context"] == true) {
        if (getKey(geminiResult, ["data", "recipe_found"], null) != null) {
          recipe = geminiResult["data"];
          String image =
              "https://image.pollinations.ai/prompt/${recipe!["recipe_title"].toString().replaceAll(" ", "-")}";
          // String image = await getImage(recipe!["recipe_title"]);
          recipe!["recipe_image"] = image;
          update();
        } else {
          showSnackbar(
            message: AppStrings.recipeNotFound,
          );
        }
      }
    } else {
      showSnackbar(message: AppStrings.ingredientNumberValidation);
    }
    EasyLoading.dismiss();
  }

  void closeRecipe() {
    recipe = null;
    update();
  }

  void settingsPopup(HomeController controller) {
    showDialog(
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              width: 196.w(Get.context!),
              height: 320.h(Get.context!),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 11.w(Get.context!),
                ),
                child: SizedBox(
                  height: 260.h(Get.context!),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14.5.h(Get.context!),
                      ),
                      AppText(
                        text: AppStrings.settings,
                        maxLines: null,
                        centered: true,
                        textAlign: TextAlign.center,
                        width: 160.w(Get.context!),
                        height: 20.h(context),
                        style: Styles.semiBold(
                          fontSize: 14.55.t(Get.context!),
                          color: AppColors.fontDark,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 11.w(Get.context!),
                        ),
                        child: SizedBox(
                          height: 275.5.h(context),
                          child: SettingsView(
                            controller: controller,
                            customMessage:
                                getKey(settings, ["custom_message"], ""),
                            servings: getKey(settings, ["servings"], ""),
                            popup: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h(Get.context!),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
      context: Get.context!,
    );
  }

  @override
  void onInit() {
    super.onInit();

    userStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .snapshots()
        .listen(
      (event) {
        userDetails = event.data() ?? {};
        print("userDetails: $userDetails");
        update();
      },
    );
    ingredientsStream = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("ingredients")
        .snapshots()
        .listen(
      (event) {
        for (DocumentChange change in event.docChanges) {
          if (change.type == DocumentChangeType.added) {
            ingredients.add(change.doc.data());
            continue;
          }
          if (change.type == DocumentChangeType.modified) {
            int index = ingredients.indexWhere(
              (element) =>
                  getKey(element, ["label"], "existing") ==
                  getKey(change.doc.data() as Map, ["label"], "change"),
            );
            ingredients[index] = change.doc.data();
            continue;
          }
          if (change.type == DocumentChangeType.removed) {
            ingredients.removeWhere(
              (element) =>
                  getKey(element, ["label"], "existing") ==
                  getKey(change.doc.data() as Map, ["label"], "change"),
            );
            continue;
          }
        }
        update();
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
