import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';

class HomeController extends GetxController {
  Map? recipe;
  Map settings = {
    "consider_current_time": true,
    "consider_allergies": true,
    "consider_diet": true,
    "time_limit": "",
    "custom_message": "",
  };
  void generateRecipe() async {
    Map geminiResult =
        await GeminiHelper.fetch(systemPrompt: AppStrings.dishPrompt, data: {
      "preferences": getStorage.read("preferences"),
      "ingredients": getStorage.read("ingredients"),
      "settings": settings,
      "current_time":
          "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}",
    });

    if (geminiResult["context"] == true) {
      recipe = geminiResult["data"];
      String image = await getImage(recipe!["recipe_title"]);
      recipe!["recipe_image"] = image;
      update();
    }
  }

  void settingsPopup() {
    TextEditingController customMessageController =
        TextEditingController(text: settings[settings]);
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: StatefulBuilder(builder: (context, setState) {
          return Container(
            width: 196.w(Get.context!),
            height: 420.h(Get.context!),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 11.w(Get.context!),
              ),
              child: SizedBox(
                height: 420.h(Get.context!),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        style: Styles.semiBold(
                          fontSize: 14.55.t(Get.context!),
                          color: AppColors.fontDark,
                        ),
                      ),
                      for (String setting in settings.keys)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 11.w(Get.context!),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: idToString(setting),
                                    style: Styles.medium(
                                      fontSize: 9.5.t(Get.context!),
                                      color: AppColors.fontDark,
                                    ),
                                  ),
                                  Switch(
                                      value: settings[setting] is String
                                          ? settings[setting]
                                              .toString()
                                              .isNotEmpty
                                          : settings[setting],
                                      onChanged: (value) {
                                        if (setting == "time_limit" ||
                                            setting == "custom_message") {
                                          if (settings[setting]
                                              .toString()
                                              .isNotEmpty) {
                                            settings[setting] = "";
                                          } else {
                                            settings[setting] = "5";
                                          }
                                        } else {
                                          settings[setting] = value;
                                        }

                                        update();
                                        setState(() {});
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 8.h(Get.context!),
                              ),
                              if (setting == "time_limit" &&
                                  settings[setting] != "")
                                CupertinoTimerPicker(
                                  initialTimerDuration: Duration(
                                    minutes: int.parse(settings["time_limit"]),
                                  ),
                                  onTimerDurationChanged: (value) {
                                    settings[setting] =
                                        value.inMinutes.toString();
                                  },
                                ),
                              if (setting == "custom_message" &&
                                  settings[setting] != "")
                                CommonTextField(
                                  controller: customMessageController,
                                  hintText:
                                      AppStrings.writeOrTypeCustomConditions,
                                  onChanged: (value) {
                                    settings[setting] = value;
                                  },
                                ),
                              Container(
                                height: 1,
                                width: 191.w(Get.context!),
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor,
                                ),
                              ),
                              SizedBox(
                                height: 8.h(Get.context!),
                              ),
                            ],
                          ),
                        ),
                      CommonButton(
                          text: AppStrings.saveAndRegenerate,
                          onTap: () {
                            getStorage.write("settings", settings);
                            generateRecipe();
                            Get.back();
                          }),
                      SizedBox(
                        height: 20.h(Get.context!),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (getStorage.read("settings") != null) {
      settings = getStorage.read("settings");
    }
    generateRecipe();
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
