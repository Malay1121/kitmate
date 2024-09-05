import 'package:kitmate/app/helper/all_imports.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../helper/gemini_helper.dart';

class IngredientsController extends GetxController {
  List ingredients = [];

  @override
  void onInit() {
    super.onInit();
    initializeSpeech();
    ingredients = getStorage.read("ingredients") ?? [];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool listening = false;
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  Future<String> getText() async {
    String result = "";
    listening = true;
    update();
    await speechToText.listen(
        listenOptions: SpeechListenOptions(listenMode: ListenMode.dictation),
        partialResults: false,
        onResult: (res) async {
          result = res.recognizedWords;
          listening = false;
          update();
          Map<String, dynamic> geminiResult = await GeminiHelper.fetch(
              systemPrompt: AppStrings.ingredientsPrompt, text: result);
          if (geminiResult["context"] == true) {
            ingredients.addAll(geminiResult["data"]);
            getStorage.write("ingredients", ingredients);
            update();
          }
        });

    return result;
  }

  void initializeSpeech() async {
    speechEnabled = await speechToText.initialize(onError: (errorNotification) {
      print(errorNotification);
      listening = false;
      update();
      EasyLoading.dismiss();
    }, onStatus: (status) {
      if (status == "done") {
        print(status);
      }
      print(status);
    });
  }

  void removeIngredient(Map ingredient) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: 196.w(Get.context!),
          height: 158.h(Get.context!),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 11.w(Get.context!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 14.5.h(Get.context!),
                ),
                AppText(
                  text:
                      "${AppStrings.areYouSureYouWantToRemove} ${ingredient["label"]}?",
                  maxLines: null,
                  centered: true,
                  textAlign: TextAlign.center,
                  width: 160.w(Get.context!),
                  style: Styles.semiBold(
                    fontSize: 14.55.t(Get.context!),
                    color: AppColors.fontDark,
                  ),
                ),
                Spacer(),
                CommonButton(
                    text: AppStrings.confirm,
                    onTap: () {
                      ingredients.remove(ingredient);

                      update();
                      getStorage.write("ingredients", ingredients);
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
  }

  void addIngredient({
    bool edit = false,
    Map? ingredient,
  }) {
    ingredient = ingredient ?? {};
    TextEditingController ingredientNameController =
        TextEditingController(text: edit ? ingredient["label"] : "");
    TextEditingController quantityController = TextEditingController(
        text: edit ? ingredient["quantity"].toString() : "");
    List<String> quantityUnits = <String>[
      AppStrings.gram,
      AppStrings.mililiter,
      AppStrings.item
    ];
    String quantityUnit =
        edit ? ingredient["quantity_unit"] : quantityUnits.first;
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: 196.w(Get.context!),
          height: 258.h(Get.context!),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 11.w(Get.context!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 14.5.h(Get.context!),
                ),
                AppText(
                  text: AppStrings.addIngredient,
                  style: Styles.semiBold(
                    fontSize: 14.55.t(Get.context!),
                    color: AppColors.fontDark,
                  ),
                ),
                SizedBox(
                  height: 14.5.h(Get.context!),
                ),
                CommonTextField(
                  hintText: AppStrings.ingredientName,
                  height: 31.5.h(Get.context!),
                  width: 174.w(Get.context!),
                  controller: ingredientNameController,
                ),
                CommonTextField(
                  hintText: AppStrings.quantity,
                  keyboardType: TextInputType.number,
                  height: 31.5.h(Get.context!),
                  width: 174.w(Get.context!),
                  controller: quantityController,
                ),
                DropdownMenu<String>(
                  width: 174.w(Get.context!),
                  hintText: AppStrings.quantityUnit,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(67),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(67),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(67),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(67),
                      borderSide: BorderSide(
                        color: AppColors.primary,
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
                    quantityUnit = value!;
                    update();
                  },
                  dropdownMenuEntries: quantityUnits
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
                SizedBox(
                  height: 20.h(Get.context!),
                ),
                CommonButton(
                    text: AppStrings.confirm,
                    onTap: () {
                      Map content = {
                        "label": ingredientNameController.text,
                        "quantity": int.parse(quantityController.text),
                        "quantity_unit": quantityUnit,
                      };
                      if (edit) {
                        int index = ingredients.indexOf(ingredient);
                        ingredients[index] = content;
                      } else {
                        ingredients.add(content);
                      }
                      update();
                      getStorage.write("ingredients", ingredients);
                      Get.back();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
