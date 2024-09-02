import 'all_imports.dart';

class AppStrings {
  static String appName = "Kitmate";

  static String commonValidation = "Please fill all the details";
  static String emailValidation = "Please enter a valid email";
  static String phoneValidation = "Please enter a valid phone number";
  static String lastNameValidation = "Please enter a valid first name";
  static String firstNameValidation = "Please enter a valid last name";
  static String profilePictureValidation =
      "Please select a valid profile picture";
  static String passwordValidation = "Please enter a valid password";
  static String passwordErrorMessage =
      "Minimum 8 characters, at least 1 lower case, at least 1 upper case, at least 1 digit";

  static String next = "Next";
  static String previous = "Previous";
  static String skip = "Skip";

  static String doYouFollowAnyOfTheseDiets =
      "Do you follow any of these diets?";
  static String anyIngredientAllergies = "Any ingredient allergies?";
  static String listOfIngredientsYouHave = "List of the ingredients you have";
  static String toOfferYouBestTailoredDiet =
      "To offer you the best tailored diet experience we need to know more information about you.";
  static String none = "None";
  static String vegan = "Vegan";
  static String paleo = "Paleo";
  static String dukan = "Dukan";
  static String vegetarian = "Vegetarian";
  static String atkins = "Atkins";
  static String intermittentFasting = "Intermittent Fasting";

  static String gluten = "Gluten";
  static String diary = "Diary";
  static String egg = "Egg";
  static String soy = "Soy";
  static String peanut = "Peanut";
  static String wheat = "Wheat";
  static String milk = "Milk";
  static String fish = "Fish";

  static String recordDiets = "Record Diets";
  static String recordIngredients = "Record Ingredients";

  static String mealPlans = "Meal Plans";
  static String storage = "Storage";

  static String allergyPrompt =
      '''Check for the ingredients that a user has allergy from depending on the descriptions they give. Users will try to say the ingredients they have allergy from and it will be then converted into text and given to you. Check for the ingredients that the user has specified or is trying to convey. 

If the user's text doesn't match the context of parameters that the user has asked for, change {"context": false}. Or else give the value and change {"context":true}.
If a particular parameter has not been talked about in the text, then return null in that particular field.

RETURN JUST THE JSON CODE, NOTHING ELSE. 

Example Input: "I have allergy from a various ingredients and they causes a few symptoms after consuming them. I have allergy from garlic, lemon and eggs."

Example Output: {"data": [{
      "label": "garlic",
"selected":true, // Will stay true no matter what
      "custom": true // Will stay true no matter what
    },{
      "label": "lemon",
"selected":true, // Will stay true no matter what
      "custom": true // Will stay true no matter what
    },{
      "label": "frequent illness",
"selected": true, // Will stay true no matter what
      "custom": true // Will stay true no matter what
    },
    {
      "label": "egg",
"selected": true, // Will stay true no matter what
      "custom": true // Will stay true no matter what
    }], "context": true}''';

  static String dietPrompt =
      '''Check for the diet that the user follows from depending on the descriptions they give. Users will try to say the diet they follow and it will be then converted into text and given to you. Check for the diet that the user has specified or is trying to convey. 

If the user's text doesn't match the context of parameters that the user has asked for, change {"context": false}. Or else give the value and change {"context":true}.
If a particular parameter has not been talked about in the text, then return null in that particular field.

RETURN JUST THE JSON CODE, NOTHING ELSE. 

Example Input: "I follow strict vegan diet, and I don't consume any dairy products."

Example Output: {"data": [{
      "label": "vegan",
"selected":true, // Will stay true no matter what
      "custom": true // Will stay true no matter what
    },], "context": true}''';
}
