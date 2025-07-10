import 'package:flutter/cupertino.dart';
import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/modules/home/controllers/home_controller.dart';

class SettingsView extends StatefulWidget {
  SettingsView(
      {super.key,
      required this.controller,
      this.customMessage,
      this.popup = false});

  HomeController controller;
  String? customMessage;
  bool popup;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TextEditingController customMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    customMessageController.text = widget.customMessage ?? "";
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: 280.h(context),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (String setting in widget.controller.settings.keys)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 11.w(Get.context!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: idToString(setting),
                              style: Styles.medium(
                                fontSize: 9.5.t(Get.context!),
                                color: AppColors.fontDark,
                              ),
                            ),
                            Switch(
                                value: widget.controller.settings[setting]
                                        is String
                                    ? widget.controller.settings[setting]
                                        .toString()
                                        .isNotEmpty
                                    : widget.controller.settings[setting],
                                onChanged: (value) {
                                  if (setting == "time_limit" ||
                                      setting == "custom_message") {
                                    if (widget.controller.settings[setting]
                                        .toString()
                                        .isNotEmpty) {
                                      widget.controller.settings[setting] = "";
                                    } else {
                                      widget.controller.settings[setting] = "5";
                                    }
                                  } else {
                                    widget.controller.settings[setting] = value;
                                  }

                                  widget.controller.update();
                                  setState(() {});
                                }),
                          ],
                        ),
                        SizedBox(
                          height: 8.h(Get.context!),
                        ),
                        if (setting == "time_limit" &&
                            widget.controller.settings[setting] != "")
                          CupertinoTimerPicker(
                            initialTimerDuration: Duration(
                              minutes: int.parse(
                                  widget.controller.settings["time_limit"]),
                            ),
                            onTimerDurationChanged: (value) {
                              widget.controller.settings[setting] =
                                  value.inMinutes.toString();
                            },
                          ),
                        if (setting == "custom_message" &&
                            widget.controller.settings[setting] != "")
                          CommonTextField(
                            controller: customMessageController,
                            hintText: AppStrings.writeOrTypeCustomConditions,
                            onChanged: (value) {
                              widget.controller.settings[setting] = value;
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
              ],
            ),
          ),
        ),
        if (!widget.popup) Spacer(),
        if (widget.popup)
          SizedBox(
            height: 10.h(context),
          ),
        CommonButton(
            text: AppStrings.saveAndGenerate,
            onTap: () {
              getStorage.write("settings", widget.controller.settings);
              widget.controller.generateRecipe();
              if (widget.popup) Get.back();
            }),
      ],
    );
  }
}
