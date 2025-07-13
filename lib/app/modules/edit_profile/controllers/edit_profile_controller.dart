import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EditProfileController extends CommonController {
  TextEditingController nameController = TextEditingController();

  List data = [
    {
      "title": AppStrings.doYouFollowAnyOfTheseDiets,
      "record": AppStrings.recordDiets,
      "prompt": AppStrings.dietPrompt,
      "id": "diet",
      "selected": []
    },
    {
      "title": AppStrings.anyIngredientAllergies,
      "record": AppStrings.recordIngredients,
      "id": "allergy",
      "prompt": AppStrings.allergyPrompt,
      "selected": []
    },
  ];

  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  bool listening = false;

  Future<String> getText(int currentPage) async {
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
    String result = "";
    if (speechEnabled) {
      listening = true;
      update();
      await speechToText.listen(
          listenOptions: SpeechListenOptions(listenMode: ListenMode.dictation),
          partialResults: false,
          onResult: (res) async {
            EasyLoading.show();

            result = res.recognizedWords;
            listening = false;
            update();
            Map<String, dynamic> geminiResult = await GeminiHelper.fetch(
                systemPrompt: data[currentPage]["prompt"], text: result);
            if (geminiResult["context"] == true) {
              List existingItems = data[currentPage]["selected"];
              print(geminiResult);
              List finalItems = [
                for (var item in existingItems) item,
                for (var item in geminiResult["data"]) item,
              ];
              data[currentPage]["selected"] = finalItems;

              update();
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

    return result;
  }

  void deleteOption(Map option, int cardPosition) {
    data[cardPosition]["selected"].remove(option);
    update();
  }

  void updateFields() {
    nameController.text = getKey(userDetails, ["name"], "");
    data[0]["selected"] = getKey(userDetails, ["preferences", "diet"], []);
    data[1]["selected"] = getKey(userDetails, ["preferences", "allergy"], []);
    update();
  }

  void updateProfile() async {
    EasyLoading.show();
    Map<String, dynamic> updatedUser = {
      "name": nameController.text,
      "preferences": {
        "allergy": getKey(data[1], ["selected"], []),
        "diet": getKey(data[0], ["selected"], []),
      },
    };
    await DatabaseHelper.editUser(
      userId: user?.uid ?? "",
      data: updatedUser,
    );
    EasyLoading.dismiss();
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    updateFields();
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
