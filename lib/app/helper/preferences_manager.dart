import 'package:speech_to_text/speech_to_text.dart';

import 'all_imports.dart';
import 'gemini_helper.dart';

class PreferencesManager {
  PreferencesManager(
      {required this.recordLabel, required this.options, required this.prompt});
  RxBool listening = false.obs;
  String recordLabel;
  RxList options;
  String prompt;

  void deleteOption(Map option) {
    options.remove(option);
  }

  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  Future<String> getText() async {
    speechEnabled = await speechToText.initialize(onError: (errorNotification) {
      listening.value = false;
      EasyLoading.dismiss();
    }, onStatus: (status) {
      if (status == "done") {
        listening.value = false;
      }
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
            Map<String, dynamic> geminiResult =
                await GeminiHelper.fetch(systemPrompt: prompt, text: result);
            if (geminiResult["context"] == true) {
              List existingItems = options;
              List finalItems = [
                for (var item in existingItems) item,
                for (var item in geminiResult["data"]) item,
              ];
              options.value = finalItems;
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

  Widget preferencesWidget() {
    return Container(
      width: 196.w(Get.context!),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.h(Get.context!),
          horizontal: 10.w(Get.context!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150.w(Get.context!),
              child: Wrap(
                runSpacing: 10.h(Get.context!),
                spacing: 10.w(Get.context!),
                children: [
                  if (options
                      .where(
                        (e) => e["custom"] == true,
                      )
                      .isEmpty)
                    AppText(
                      text: recordLabel,
                      maxLines: null,
                      width: 150.w(Get.context!),
                      style: Styles.semiBold(
                        fontSize: 14,
                        color: AppColors.fontGrey,
                      ),
                    ),
                  for (var option in options.where(
                    (e) => e["custom"] == true,
                  ))
                    GestureDetector(
                      onTap: () => deleteOption(option),
                      child: Container(
                        decoration: BoxDecoration(
                          color: option["selected"]
                              ? AppColors.primary
                              : AppColors.fontGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2.h(Get.context!),
                            horizontal: 11.w(Get.context!),
                          ),
                          child: AppText(
                            text: option["label"],
                            style: Styles.semiBold(
                                color: option["selected"]
                                    ? AppColors.white
                                    : AppColors.fontGrey,
                                fontSize: 9.53.t(Get.context!)),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!listening.value) {
                  try {
                    getText();
                  } catch (e) {
                    listening.value = false;
                    EasyLoading.dismiss();
                  }
                }
              },
              child: Container(
                height: 20.h(Get.context!),
                width: 20.w(Get.context!),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(
                  listening.value ? Icons.stop : Icons.mic,
                  size: 10.t(Get.context!),
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
