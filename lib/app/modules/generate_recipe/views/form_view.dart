import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/modules/generate_recipe/controllers/generate_recipe_controller.dart';

class FormView extends StatefulWidget {
  FormView({super.key, required this.id, required this.controller});
  String id;
  GenerateRecipeController controller;

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  @override
  Widget build(BuildContext context) {
    switch (widget.id) {
      case "meal_type":
        return Wrap(
          spacing: 5.w(Get.context!),
          runSpacing: 4.h(Get.context!),
          children: [
            for (String type in widget.controller.mealTypes)
              GestureDetector(
                onTap: () {
                  if (widget.controller.settingsData["meal_type"]["selected"]
                      .contains(type)) {
                    widget.controller.settingsData["meal_type"]["selected"]
                        .remove(type);
                  } else {
                    widget.controller.settingsData["meal_type"]["selected"]
                        .add(type);
                  }
                  widget.controller.update();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget
                            .controller.settingsData["meal_type"]["selected"]
                            .contains(type)
                        ? AppColors.primary
                        : AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w(Get.context!),
                    vertical: 4.h(Get.context!),
                  ),
                  child: AppText(
                    text: type,
                    style: Styles.regular(
                      color: widget
                              .controller.settingsData["meal_type"]["selected"]
                              .contains(type)
                          ? AppColors.white
                          : AppColors.fontDark,
                      fontSize: 8.t(Get.context!),
                    ),
                  ),
                ),
              ),
          ],
        );
      case "dish_name":
        return Column(
          children: [
            CommonTextField(
              hintText: AppStrings.typeRecipeName,
            ),
            SizedBox(
              height: 4.h(Get.context!),
            ),
            AppText(
              text: AppStrings.or,
              style: Styles.regular(
                fontSize: 8.t(Get.context!),
                color: AppColors.fontGrey,
              ),
            ),
            SizedBox(
              height: 4.h(Get.context!),
            ),
            GestureDetector(
              onTap: () {
                widget.controller.settingsData["dish_name"]["enabled"] =
                    !(widget.controller.settingsData["dish_name"]["enabled"] ??
                        false);
                widget.controller.update();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: min(12.h(Get.context!), 12.w(Get.context!)),
                    height: min(12.h(Get.context!), 12.w(Get.context!)),
                    decoration: BoxDecoration(
                      color: widget.controller.settingsData["dish_name"]
                                  ["enabled"] ==
                              false
                          ? AppColors.primary
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: widget.controller.settingsData["dish_name"]
                                  ["enabled"] !=
                              false
                          ? Border.all(color: AppColors.black)
                          : null,
                    ),
                    child: widget.controller.settingsData["dish_name"]
                                ["enabled"] ==
                            false
                        ? Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 8.t(context),
                          )
                        : SizedBox(),
                  ),
                  SizedBox(
                    width: 4.w(Get.context!),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: AppStrings.generateMultipleDishes,
                        maxLines: null,
                        width: 192.w(Get.context!) -
                            min(12.w(Get.context!), 12.h(Get.context!)),
                        style: Styles.medium(
                          color: AppColors.fontDark,
                          fontSize: 9.t(Get.context!),
                        ),
                      ),
                      AppText(
                        text: AppStrings.ifYouDontKnowWhatDishToCook,
                        width: 192.w(Get.context!) -
                            min(12.h(Get.context!), 12.w(Get.context!)),
                        maxLines: null,
                        style: Styles.regular(
                          color: AppColors.fontGrey,
                          fontSize: 8.t(Get.context!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      case "allergy_preferences":
        return StreamBuilder(
          stream: widget.controller.allergyManager.listening.stream,
          builder: (context, snapshot) => StreamBuilder(
            stream: widget.controller.allergyManager.options.stream,
            builder: (context, snapshot) =>
                widget.controller.allergyManager.preferencesWidget(),
          ),
        );
      case "diet_preferences":
        return StreamBuilder(
          stream: widget.controller.dietManager.listening.stream,
          builder: (context, snapshot) => StreamBuilder(
            stream: widget.controller.dietManager.options.stream,
            builder: (context, snapshot) =>
                widget.controller.dietManager.preferencesWidget(),
          ),
        );
      case "pantry_match":
        return Wrap(
          spacing: 5.w(Get.context!),
          runSpacing: 4.h(Get.context!),
          children: [
            for (String type in widget.controller.pantryMatch)
              GestureDetector(
                onTap: () {
                  widget.controller.settingsData["pantry_match"]["selected"] =
                      type;
                  widget.controller.update();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.controller.settingsData["pantry_match"]
                                ["selected"] ==
                            type
                        ? AppColors.primary
                        : AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 62.w(context),
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h(Get.context!),
                  ),
                  child: AppText(
                    centered: true,
                    text: type,
                    style: Styles.regular(
                      color: widget.controller.settingsData["pantry_match"]
                                  ["selected"] ==
                              type
                          ? AppColors.white
                          : AppColors.fontDark,
                      fontSize: 8.t(Get.context!),
                    ),
                  ),
                ),
              ),
          ],
        );
      case "time_limit":
        return Wrap(
          spacing: 5.w(Get.context!),
          runSpacing: 4.h(Get.context!),
          children: [
            for (String type in widget.controller.timeBound)
              GestureDetector(
                onTap: () {
                  widget.controller.settingsData["time_limit"]["enabled"] =
                      !widget.controller.settingsData["time_limit"]["enabled"];
                  if (type == AppStrings.disable) {
                    widget.controller.settingsData["time_limit"]["selected"] =
                        null;
                  }
                  widget.controller.update();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.controller.settingsData["time_limit"]
                                        ["enabled"] ==
                                    true &&
                                type == AppStrings.enable ||
                            widget.controller.settingsData["time_limit"]
                                        ["enabled"] ==
                                    false &&
                                type == AppStrings.disable
                        ? AppColors.primary
                        : AppColors.cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 95.5.w(context),
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h(Get.context!),
                  ),
                  child: AppText(
                    centered: true,
                    text: type,
                    style: Styles.regular(
                      color: widget.controller.settingsData["time_limit"]
                                          ["enabled"] ==
                                      true &&
                                  type == AppStrings.enable ||
                              widget.controller.settingsData["time_limit"]
                                          ["enabled"] ==
                                      false &&
                                  type == AppStrings.disable
                          ? AppColors.white
                          : AppColors.fontDark,
                      fontSize: 8.t(Get.context!),
                    ),
                  ),
                ),
              ),
            if (widget.controller.settingsData["time_limit"]["enabled"] == true)
              Padding(
                padding: EdgeInsets.only(top: 5.h(context)),
                child: CupertinoTimerPicker(
                  initialTimerDuration: Duration(
                    minutes: int.parse(
                        (widget.controller.settingsData["selected"] ?? 0)
                            .toString()),
                  ),
                  onTimerDurationChanged: (value) {
                    widget.controller.settingsData["selected"] =
                        value.inMinutes.toString();
                  },
                ),
              ),
          ],
        );
      case "custom_message":
        return GestureDetector(
          onTap: () => proPopup(),
          child: CommonTextField(
            // controller: customMessageController,
            enabled: widget.controller.pro,
            hintText: AppStrings.writeOrTypeCustomConditions,

            maxLines: 4,
            height: 50.h(context),
            onChanged: (value) {
              widget.controller.settingsData["custom_message"]["selected"] =
                  value;
            },
          ),
        );
      case "servings":
        return GestureDetector(
          onTap: () => proPopup(),
          child: CommonTextField(
            // controller: servingsController,
            hintText: AppStrings.numberOfDishes,
            enabled: widget.controller.pro,
            onChanged: (value) {
              widget.controller.settingsData["servings"]["selected"] = value;
            },
          ),
        );
      default:
        return Container();
    }
  }
}
