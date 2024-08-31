import 'package:get/get.dart';
import 'package:kitmate/app/helper/all_imports.dart';

class OnboardingController extends GetxController {
  int currentPage = 0;
  List data = [
    {
      "title": AppStrings.doYouFollowAnyOfTheseDiets,
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
        Get.offAllNamed(Routes.HOME);
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

  void toggleOption(int index) {
    data[currentPage]["options"][index]["selected"] =
        !data[currentPage]["options"][index]["selected"];
    update();
  }

  @override
  void onInit() {
    super.onInit();
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
