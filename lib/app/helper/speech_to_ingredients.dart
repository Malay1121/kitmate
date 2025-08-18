import 'package:speech_to_text/speech_to_text.dart';

import 'all_imports.dart';
import 'gemini_helper.dart';

class SpeechToIngredients {
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  RxBool listening = false.obs;

  Future<String?> getText(User user) async {
    speechEnabled = await speechToText.initialize(onError: (errorNotification) {
      // print(errorNotification);
      listening.value = false;
      return;
    }, onStatus: (status) {
      if (status == "done") {
        // print(status);
      }
      // print(status);
    });
    String result = "";
    if (speechEnabled) {
      listening.value = true;

      await speechToText.listen(
          listenOptions: SpeechListenOptions(listenMode: ListenMode.dictation),
          partialResults: false,
          onResult: (res) async {
            EasyLoading.show();

            result = res.recognizedWords;
            listening.value = false;
            EasyLoading.show();
            Map<String, dynamic> geminiResult = await GeminiHelper.fetch(
                systemPrompt: AppStrings.ingredientsPrompt, text: result);
            if (geminiResult["context"] == true) {
              Map result = geminiResult["data"];
              List ingredientsList = [];
              for (Map ingredient in getKey(result, ["add"], [])) {
                ingredient.addEntries({"operation": "add"}.entries);
                ingredientsList.add(ingredient);
              }
              for (Map ingredient in getKey(result, ["remove"], [])) {
                ingredient.addEntries({"operation": "remove"}.entries);
                ingredientsList.add(ingredient);
              }
              // print(result);
              // print(ingredientsList);
              confirmIngredients(
                  ingredientsList: ingredientsList.obs, user: user);
            }
            EasyLoading.dismiss();
          });
    } else {
      if (!(await speechToText.hasPermission)) {
        showSnackbar(message: AppStrings.youHaveDeniedMicPermission);
      } else {
        showSnackbar(message: "Error with Speech");
      }
    }
    EasyLoading.dismiss();

    return result;
  }

  void confirmIngredients({
    required RxList ingredientsList,
    required User user,
  }) async {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: StatefulBuilder(builder: (context, setState) {
          return Container(
            height: 320.h(Get.context!),
            width: 196.w(Get.context!),
            constraints: BoxConstraints(
              maxHeight: 400.h(Get.context!),
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 11.w(Get.context!), vertical: 11.h(Get.context!)),
              child: StreamBuilder(
                  stream: ingredientsList.stream,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          text: AppStrings.confirmIngredients,
                          style: Styles.semiBold(
                            fontSize: 14.55.t(Get.context!),
                            color: AppColors.fontDark,
                          ),
                        ),
                        SizedBox(
                          height: 14.5.h(Get.context!),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: ingredientsList.length,
                            itemBuilder: (context, ind) {
                              Map ingredient = ingredientsList[ind];
                              TextEditingController ingredientNameController =
                                  TextEditingController(
                                      text: getKey(ingredient, ["label"], ""));
                              TextEditingController quantityController =
                                  TextEditingController(
                                      text: getKey(ingredient, ["quantity"], "")
                                          .toString());
                              List<String> quantityUnits = <String>[
                                AppStrings.gram,
                                AppStrings.mililiter,
                                AppStrings.pieces
                              ];
                              String quantityUnit =
                                  getKey(ingredient, ["quantity_unit"], "");
                              return Container(
                                width: 174.w(context),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w(context),
                                  vertical: 5.h(context),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.cardColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 10.h(Get.context!),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 28.h(context),
                                          width: 100.w(context),
                                          child: TextField(
                                            controller:
                                                ingredientNameController,
                                            onChanged: (p0) {
                                              setState(() {
                                                ingredientsList[ind]["label"] =
                                                    p0;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.lightGrey,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.w(context),
                                        ),
                                        CommonButton(
                                          text: AppStrings.add,
                                          width: 30.w(context),
                                          height: 20.h(context),
                                          onTap: () {
                                            setState(() {
                                              int index = ingredientsList
                                                  .indexOf(ingredient);
                                              ingredientsList[index]
                                                      ["operation"] =
                                                  ingredientsList[index]
                                                              ["operation"] ==
                                                          "add"
                                                      ? "remove"
                                                      : "add";
                                            });
                                          },
                                          backgroundColor: getKey(ingredient,
                                                          ["operation"], "")
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "add"
                                              ? AppColors.primary
                                              : AppColors.cardColor,
                                          textColor: getKey(ingredient,
                                                          ["operation"], "")
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "add"
                                              ? AppColors.white
                                              : AppColors.primary,
                                        ),
                                        SizedBox(
                                          width: 1.w(context),
                                        ),
                                        CommonButton(
                                          text: AppStrings.remove,
                                          width: 30.w(context),
                                          height: 20.h(context),
                                          onTap: () {
                                            setState(() {
                                              int index = ingredientsList
                                                  .indexOf(ingredient);
                                              ingredientsList[index]
                                                      ["operation"] =
                                                  ingredientsList[index]
                                                              ["operation"] ==
                                                          "add"
                                                      ? "remove"
                                                      : "add";
                                            });
                                          },
                                          backgroundColor: getKey(ingredient,
                                                          ["operation"], "")
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "remove"
                                              ? AppColors.primary
                                              : AppColors.cardColor,
                                          textColor: getKey(ingredient,
                                                          ["operation"], "")
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "remove"
                                              ? AppColors.white
                                              : AppColors.primary,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.w(context),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 28.h(context),
                                          width: 79.5.w(context),
                                          child: TextField(
                                            controller: quantityController,
                                            keyboardType: TextInputType.number,
                                            onChanged: (p0) {
                                              ingredientsList[ind]["quantity"] =
                                                  p0;
                                            },
                                            decoration: InputDecoration(
                                              // isDense: true,
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.lightGrey,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w(context),
                                        ),
                                        DropdownMenu<String>(
                                          width: 79.5.w(Get.context!),
                                          hintText: AppStrings.quantityUnit,
                                          initialSelection: quantityUnit,
                                          inputDecorationTheme:
                                              InputDecorationTheme(
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: AppColors.primary,
                                                width: 1,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: AppColors.primary,
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: AppColors.primary,
                                                width: 1,
                                              ),
                                            ),
                                            constraints: BoxConstraints.tight(
                                                Size.fromHeight(28.h(context))),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: AppColors.lightGrey,
                                                width: 1,
                                              ),
                                            ),
                                            fillColor: AppColors.white,
                                            hintStyle: Styles.medium(
                                              color: AppColors.fontGrey,
                                            ),
                                          ),
                                          textStyle: Styles.semiBold(
                                            color: AppColors.fontDark,
                                          ),
                                          onSelected: (String? value) {
                                            setState(() {
                                              ingredientsList[ind]
                                                  ["quantity_unit"] = value!;
                                              quantityUnit = value;
                                            });
                                          },
                                          dropdownMenuEntries: quantityUnits
                                              .map<DropdownMenuEntry<String>>(
                                                  (String value) {
                                            return DropdownMenuEntry<String>(
                                                value: value, label: value);
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h(Get.context!),
                        ),
                        CommonButton(
                            text: AppStrings.confirm,
                            onTap: () async {
                              EasyLoading.show();
                              await DatabaseHelper.updateIngredientsFromGemini(
                                userId: user.uid ?? "",
                                add: true,
                                ingredients: ingredientsList
                                    .where(
                                      (element) =>
                                          element["operation"] == "add",
                                    )
                                    .toList(),
                              );
                              await DatabaseHelper.updateIngredientsFromGemini(
                                  userId: user.uid ?? "",
                                  add: false,
                                  ingredients: ingredientsList
                                      .where(
                                        (element) =>
                                            element["operation"] == "remove",
                                      )
                                      .toList());
                              EasyLoading.dismiss();

                              Get.back();
                            }),
                        SizedBox(
                          height: 5.h(Get.context!),
                        ),
                        CommonButton(
                          text: AppStrings.cancel,
                          backgroundColor: AppColors.cardColor,
                          textColor: AppColors.fontDark,
                          onTap: () => Get.back(),
                        ),
                      ],
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}
