import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/voice_assistant_manager.dart';
import 'dart:async';

class RecipeController extends CommonController {
  Map? recipe;
  List steps = [];
  int currentStep = 0;
  bool isVoiceAssistantActive = false;
  List<Timer> activeTimers = [];
  StreamSubscription? _commandSubscription;
  @override
  void onInit() {
    super.onInit();
    _initializeVoiceAssistant();
  }

  Future<void> _initializeVoiceAssistant() async {
    bool initialized = await VoiceAssistantManager.instance.initialize();
    if (initialized) {
      isVoiceAssistantActive = false;
      update();
    }
  }

  Future<void> toggleVoiceAssistant() async {
    if (isVoiceAssistantActive) {
      await stopVoiceAssistant();
    } else {
      await startVoiceAssistant();
    }
  }

  Future<void> startVoiceAssistant() async {
    bool initialized = await VoiceAssistantManager.instance.initialize();
    if (initialized) {
      await VoiceAssistantManager.instance.startContinuousListening();
      _commandSubscription = VoiceAssistantManager.instance.commandStream
          .listen(handleVoiceCommand);
      isVoiceAssistantActive = true;
      update();
      await VoiceAssistantManager.instance.speak(
          'Voice assistant activated. Say next step, previous step, repeat, or help.');
    }
  }

  Future<void> stopVoiceAssistant() async {
    VoiceAssistantManager.instance.stopContinuousListening();
    _commandSubscription?.cancel();
    isVoiceAssistantActive = false;
    update();
  }

  void handleVoiceCommand(String command) {
    print('Processing voice command: $command');

    if (command.contains('next step') || command.contains('next')) {
      nextStep();
    } else if (command.contains('previous step') ||
        command.contains('back') ||
        command.contains('go back') ||
        command.contains('previous')) {
      previousStep();
    } else if (command.contains('repeat') || command.contains('again')) {
      repeatCurrentStep();
    } else if (command.contains('timer')) {
      handleTimerCommand(command);
    } else if (command.contains('ingredient') ||
        command.contains('ingredients')) {
      speakIngredients();
    } else if (command.contains('temperature') || command.contains('temp')) {
      speakTemperature();
    } else if (command.contains('help')) {
      speakHelp();
    } else if (command.contains('pause')) {
      pauseCooking();
    } else if (command.contains('continue')) {
      continueCooking();
    }
  }

  void repeatCurrentStep() {
    if (steps.isNotEmpty && currentStep < steps.length) {
      Map currentStepData = steps[currentStep];
      String instruction = currentStepData['instruction'] ?? '';
      VoiceAssistantManager.instance
          .speak('Repeating step ${currentStep + 1}: $instruction');
    }
  }

  void handleTimerCommand(String command) {
    RegExp timeRegex =
        RegExp(r'(\d+)\s*(minute|minutes|min|second|seconds|sec)');
    Match? match = timeRegex.firstMatch(command);

    if (match != null) {
      int duration = int.parse(match.group(1)!);
      String unit = match.group(2)!;

      int seconds = unit.contains('minute') || unit.contains('min')
          ? duration * 60
          : duration;

      startTimer(seconds);
      VoiceAssistantManager.instance.speak('Timer set for $duration ${unit}');
    } else {
      if (steps.isNotEmpty && currentStep < steps.length) {
        Map currentStepData = steps[currentStep];
        if (currentStepData['timer'] != null) {
          int timerMinutes = currentStepData['timer'];
          startTimer(timerMinutes * 60);
          VoiceAssistantManager.instance
              .speak('Timer set for $timerMinutes minutes');
        } else {
          VoiceAssistantManager.instance
              .speak('No timer specified for this step');
        }
      }
    }
  }

  void startTimer(int seconds) {
    Timer timer = Timer(Duration(seconds: seconds), () {
      VoiceAssistantManager.instance
          .speak('Timer finished! Check your cooking.');
      update();
    });
    activeTimers.add(timer);

    Timer.periodic(Duration(seconds: seconds), (timer) {
      activeTimers.removeWhere((t) => t == timer);
      timer.cancel();
    });

    update();
  }

  void speakIngredients() {
    if (recipe != null && recipe!['ingredients'] != null) {
      List ingredients = recipe!['ingredients'];
      if (ingredients.isNotEmpty) {
        String ingredientText = 'Ingredients needed: ';
        for (var ingredient in ingredients.take(3)) {
          ingredientText +=
              '${ingredient['quantity']} ${ingredient['quantity_unit']} of ${ingredient['label']}, ';
        }
        if (ingredients.length > 3) {
          ingredientText += 'and ${ingredients.length - 3} more ingredients.';
        }
        VoiceAssistantManager.instance.speak(ingredientText);
      }
    } else {
      VoiceAssistantManager.instance
          .speak('No ingredients information available');
    }
  }

  void speakTemperature() {
    if (steps.isNotEmpty && currentStep < steps.length) {
      Map currentStepData = steps[currentStep];
      if (currentStepData['temperature'] != null) {
        String temp = currentStepData['temperature'].toString();
        VoiceAssistantManager.instance
            .speak('Set temperature to $temp degrees');
      } else {
        VoiceAssistantManager.instance
            .speak('No specific temperature for this step');
      }
    }
  }

  void speakHelp() {
    VoiceAssistantManager.instance.speak(
        'You can say: next step, previous step, repeat, set timer, ingredients, temperature, or help');
  }

  void pauseCooking() {
    stopVoiceAssistant();
    VoiceAssistantManager.instance
        .speak('Cooking paused. Tap the microphone to continue.');
  }

  void continueCooking() {
    startVoiceAssistant();
  }

  void nextStep({bool removeIngredients = true}) async {
    if (steps.length <= currentStep + 1) {
      if (removeIngredients) {
        EasyLoading.show();
        await DatabaseHelper.updateIngredientsFromGemini(
            userId: user?.uid ?? "",
            add: false,
            ingredients: getKey(recipe ?? {}, ["ingredients"], []));
      }
      EasyLoading.dismiss();

      if (isVoiceAssistantActive) {
        await VoiceAssistantManager.instance.speak(
            'Congratulations! You have completed all steps. Your dish is ready.');
      }
      Get.back();
    } else {
      currentStep++;
      update();

      if (isVoiceAssistantActive && steps.isNotEmpty) {
        Map currentStepData = steps[currentStep];
        String instruction = currentStepData['instruction'] ?? '';
        await VoiceAssistantManager.instance
            .speak('Step ${currentStep + 1}: $instruction');
      }
    }
  }

  void previousStep() {
    if (0 >= currentStep) {
      Get.back();
    } else {
      currentStep--;
      update();

      if (isVoiceAssistantActive && steps.isNotEmpty) {
        Map currentStepData = steps[currentStep];
        String instruction = currentStepData['instruction'] ?? '';
        VoiceAssistantManager.instance
            .speak('Going back to step ${currentStep + 1}: $instruction');
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      recipe = Get.arguments;
      steps = recipe!["steps"];
      update();
    } else {
      Get.back();
    }
  }

  @override
  void onClose() {
    for (Timer timer in activeTimers) {
      timer.cancel();
    }
    _commandSubscription?.cancel();
    VoiceAssistantManager.instance.stopContinuousListening();
    super.onClose();
  }
}
