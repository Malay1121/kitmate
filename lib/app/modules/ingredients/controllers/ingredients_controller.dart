import 'package:kitmate/app/helper/all_imports.dart';

import '../../../helper/gemini_helper.dart';

class IngredientsController extends CommonController {
  List visibleIngredients = [];
  TextEditingController searchController = TextEditingController();
  bool isDialOpen = false;
  @override
  void onInit() {
    super.onInit();

    update();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String searchText = "";

  void onSearch(String text) {
    searchText = text;
    update();
  }

  File? profilePicture;

  void pickBillImage(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      profilePicture = File(image.path);
      getIngredientsFromBill(InputImage.fromFile(profilePicture!));
      update();
    }
    Get.back();
  }

  void selectBillPicture() async {
    Get.bottomSheet(
      Container(
        width: 220.w(Get.context!),
        height: 166.h(Get.context!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 4.h(Get.context!)),
            Container(
              width: 38.w(Get.context!),
              height: 1.h(Get.context!),
              color: AppColors.fontGrey,
            ),
            SizedBox(height: 14.h(Get.context!)),
            AppText(
              text: AppStrings.selectImageSource,
              style: Styles.bold(
                color: AppColors.fontDark,
                fontSize: 14.t(Get.context!),
              ),
            ),
            SizedBox(height: 10.h(Get.context!)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => pickBillImage(ImageSource.camera),
                  child: Container(
                    width: 95.w(Get.context!),
                    height: 80.h(Get.context!),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 20.t(Get.context!),
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10.h(Get.context!)),
                        AppText(
                          text: AppStrings.camera,
                          style: Styles.semiBold(
                            fontSize: 9.t(Get.context!),
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w(Get.context!)),
                GestureDetector(
                  onTap: () => pickBillImage(ImageSource.gallery),
                  child: Container(
                    width: 95.w(Get.context!),
                    height: 80.h(Get.context!),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 20.t(Get.context!),
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10.h(Get.context!)),
                        AppText(
                          text: AppStrings.gallery,
                          style: Styles.semiBold(
                            fontSize: 9.t(Get.context!),
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getIngredientsFromBill(InputImage inputImage) async {
    EasyLoading.show();
    final textRecognizer = TextRecognizer();

    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    print("Recognized text: " + recognizedText.text);
    Map<String, dynamic> geminiResult = await GeminiHelper.fetch(
        systemPrompt: AppStrings.ingredientsFromBillPrompt,
        text: recognizedText.text);
    EasyLoading.dismiss();
    if (geminiResult["context"] == true) {
      Map result = geminiResult["data"];
      confirmIngredients(ingredientsList: getKey(result, ["ingredients"], []));
    }
  }

  SpeechToIngredients speechToIngredients = SpeechToIngredients();

  void removeIngredient(Map ingredient) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: 196.w(Get.context!),
          height: 118.h(Get.context!),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
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
                AppRichText(
                  text: TextSpan(
                    text: "${AppStrings.areYouSureYouWantToRemove} ",
                    children: [
                      TextSpan(
                        text: getKey(ingredient, ["label"], ""),
                        style: Styles.semiBold(
                          fontSize: 14.55.t(Get.context!),
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(text: "?"),
                    ],
                  ),
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
                    onTap: () async {
                      EasyLoading.show();

                      var result = await DatabaseHelper.removeIngredients(
                          userId: user?.uid ?? "", ingredients: [ingredient]);
                      if (result != null) {
                        update();
                        EasyLoading.dismiss();

                        Get.back();
                      }
                      EasyLoading.dismiss();
                    }),
                SizedBox(
                  height: 10.h(Get.context!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirmIngredients({
    required List ingredientsList,
  }) async {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
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
            child: Column(
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
                        child: Column(
                          children: [
                            SizedBox(
                              height: 28.h(context),
                              width: 164.w(context),
                              child: TextField(
                                controller: ingredientNameController,
                                onChanged: (p0) {
                                  ingredientsList[ind]["label"] = p0;
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
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
                                      ingredientsList[ind]["quantity"] = p0;
                                    },
                                    decoration: InputDecoration(
                                      // isDense: true,
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.lightGrey,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
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
                                  inputDecorationTheme: InputDecorationTheme(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                        width: 1,
                                      ),
                                    ),
                                    constraints: BoxConstraints.tight(
                                        Size.fromHeight(28.h(context))),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                                    ingredientsList[ind]["quantity_unit"] =
                                        value!;
                                    quantityUnit = value;
                                    update();
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
                      var databaseResult =
                          await DatabaseHelper.updateIngredientsFromGemini(
                              userId: user?.uid ?? "",
                              add: true,
                              ingredients: ingredients);
                      Get.back();
                      EasyLoading.dismiss();
                    }),
                CommonButton(
                  text: AppStrings.cancel,
                  backgroundColor: AppColors.cardColor,
                  textColor: AppColors.fontDark,
                  onTap: () => Get.back(),
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
      AppStrings.pieces
    ];
    String quantityUnit =
        edit ? ingredient["quantity_unit"] : quantityUnits.first;
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: 196.w(Get.context!),
          constraints: BoxConstraints(
            maxHeight: 218.h(Get.context!),
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
              children: [
                AppText(
                  text: edit
                      ? AppStrings.updateIngredient
                      : AppStrings.addIngredient,
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
                  // height: 22.5,
                  width: 174,
                  controller: ingredientNameController,
                ),
                SizedBox(
                  height: 5.h(Get.context!),
                ),
                CommonTextField(
                  hintText: AppStrings.quantity,
                  keyboardType: TextInputType.number,
                  // height: 22.5,
                  width: 174,
                  controller: quantityController,
                ),
                SizedBox(
                  height: 5.h(Get.context!),
                ),
                DropdownMenu<String>(
                  width: 174.w(Get.context!),
                  hintText: AppStrings.quantityUnit,
                  initialSelection: quantityUnit,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    fillColor: AppColors.white,
                    hintStyle: Styles.medium(
                      color: AppColors.fontGrey,
                    ),
                    constraints: BoxConstraints.tight(
                        Size.fromHeight(28.h(Get.context!))),
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
                    onTap: () async {
                      EasyLoading.show();

                      if (edit) {
                        ingredient!["label"] = ingredientNameController.text;
                        ingredient["quantity"] =
                            int.parse(quantityController.text);
                        ingredient["quantity_unit"] = quantityUnit;
                        var result = await DatabaseHelper.updateIngredient(
                          userId: user?.uid ?? "",
                          data: ingredient! as Map<String, dynamic>,
                        );
                        if (result != null) {
                          Get.back();
                        }
                      } else {
                        Map<String, dynamic> content = {
                          "label": ingredientNameController.text,
                          "quantity": int.parse(quantityController.text),
                          "quantity_unit": quantityUnit,
                        };
                        var result = await DatabaseHelper.addIngredients(
                          userId: user?.uid ?? "",
                          ingredients: [content],
                        );

                        if (result != null) {
                          Get.back();
                        }
                      }
                      EasyLoading.dismiss();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
