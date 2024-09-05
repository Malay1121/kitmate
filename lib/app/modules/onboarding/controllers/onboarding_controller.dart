import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/gemini_helper.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class OnboardingController extends CommonController {
  int currentPage = 0;
  bool listening = false;
  List data = [
    {
      "title": AppStrings.doYouFollowAnyOfTheseDiets,
      "record": AppStrings.recordDiets,
      "prompt": AppStrings.dietPrompt,
      "id": "diet",
      "options": [
        {
          "label": AppStrings.none,
          "selected": false,
        },
        {
          "label": AppStrings.vegan,
          "selected": false,
        },
        {
          "label": AppStrings.paleo,
          "selected": false,
        },
        {
          "label": AppStrings.dukan,
          "selected": false,
        },
        {
          "label": AppStrings.vegetarian,
          "selected": false,
        },
        {
          "label": AppStrings.atkins,
          "selected": false,
        },
        {
          "label": AppStrings.intermittentFasting,
          "selected": false,
        },
      ]
    },
    {
      "title": AppStrings.anyIngredientAllergies,
      "record": AppStrings.recordIngredients,
      "id": "allergy",
      "prompt": AppStrings.allergyPrompt,
      "options": [
        {
          "label": AppStrings.gluten,
          "selected": false,
        },
        {
          "label": AppStrings.diary,
          "selected": false,
        },
        {
          "label": AppStrings.egg,
          "selected": false,
        },
        {
          "label": AppStrings.soy,
          "selected": false,
        },
        {
          "label": AppStrings.peanut,
          "selected": false,
        },
        {
          "label": AppStrings.wheat,
          "selected": false,
        },
        {
          "label": AppStrings.milk,
          "selected": false,
        },
        {
          "label": AppStrings.fish,
          "selected": false,
        },
      ]
    },
  ];

  void navigate(bool next) {
    if (next) {
      if (currentPage >= data.length - 1) {
        Map<String, List> preferences = {
          "allergy": [],
          "diet": [],
        };
        for (Map page in data) {
          preferences[page["id"]] =
              page["options"].where((e) => e["selected"] == true).toList();
        }

        getStorage.write("preferences", preferences);
        getStorage.write("loggedin", true);
        getStorage.write("settings", {
          "consider_current_time": true,
          "consider_allergies": true,
          "consider_diet": true,
          "time_limit": "",
          "custom_message": "",
        });
        Get.offAllNamed(Routes.INGREDIENTS);
      } else {
        currentPage++;
        update();
      }
    } else {
      if (currentPage <= 0) {
      } else {
        currentPage--;
        update();
      }
    }
  }

  void toggleOption(Map option) {
    int index = data[currentPage]["options"].indexOf(option);
    data[currentPage]["options"][index]["selected"] =
        !data[currentPage]["options"][index]["selected"];
    update();
  }

  void deleteOption(Map option) {
    data[currentPage]["options"].remove(option);
    update();
  }

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
              systemPrompt: data[currentPage]["prompt"], text: result);
          if (geminiResult["context"] == true) {
            List existingItems = data[currentPage]["options"];
            print(geminiResult);
            List finalItems = [
              for (var item in existingItems) item,
              for (var item in geminiResult["data"]) item,
            ];
            data[currentPage]["options"] = finalItems;

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

  @override
  void onInit() {
    super.onInit();
    initializeSpeech();
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
