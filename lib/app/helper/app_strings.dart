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

  static String generatingARecipe =
      "Generating a personalized recipe just for you! ~ 10 seconds";
  static String startCooking = "Start Cooking";

  static String ingredientsInStock = "Ingredients in stock";
  static String noIngredientsAddedYet = "No ingredients added yet!";
  static String addIngredient = "Add ingredient";
  static String areYouSureYouWantToRemove = "Are you sure you want to remove";
  static String confirm = "Confirm";
  static String addIngredientWithSpeech = "Add ingredients with speech";
  static String ingredientName = "Ingredient name";
  static String quantity = "Quantity";
  static String quantityUnit = "Quantity Unit";
  static String gram = "Gram(g)";
  static String mililiter = "Mililiter(ml)";
  static String item = "Item(1,2,3,4,...)";

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

  static String dishPrompt = '''
  Suggest a dish that a user can make to eat depending on their preferences(What diet they eat, and what allergies do they have) and ingredients that are available with them. There will be a JSON object that will contain the preferences and ingredients that the user has. The ingredients will also have its quantity and the unit. For example quantity: 100, quantity_unit: grams, which means the user has 100 grams of that ingredient. Check for the ingredients that the user has specified and provide a best recipe that they can make and is compatible to their preferences. If no ingredients given, you can return any good recipe depending on the preferences or vice versa. If none is provided then give a random recipe. Give a detailed recipe which the user can follow. Also return an image of that dish with the recipe, and a few statistics about the recipe(statitcs to include: Energy(k), protein(g)m Carbs(g), Fat(g)).

If the user's text doesn't match the context of parameters that the user has asked for, change {"context": false}. Or else give the value and change {"context":true}.
If a particular parameter has not been talked about in the text, then return null in that particular field.

RETURN JUST THE JSON CODE, NOTHING ELSE. 

Output structure: {"data": {
  "recipe_title": "Title of the recipe",
"recipe_type": "Type of the recipe for example Lunch, Dinner, Breakfast, High tea, etc"
  "recipe_image": "An image of the dish",
  "statistics": {
    "energy": 0, // energy(k) in the dish
    "protein": 0, // protein(g) in the dish
    "carbs": 0, // carbs(g) in the dish
    "fat": 0, // fat(g) in the dish
  },
  "time": "Time it takes to prepare the dish"
  "ingredients": [
    {
      "name": "Ingredient 1", "quantity": "quantity of the ingredient",
    },
    {
      "name": "Ingredient 2", "quantity": "quantity of the ingredient",
    },
    {
      "name": "Ingredient 3", "quantity": "quantity of the ingredient",
    }
  ],
  "steps": [
    {
      "step_no": 1,
      "ingredients_req": [
        {
          "name": "Ingredient 1", "quantity": "quantity of the ingredient required in this step",
        },
        {
          "name": "Ingredient 2", "quantity": "quantity of the ingredient required in this step",
        },
      ],
      "procedure": "Describe the whole procedure on what to do"
    },
  ]
}, "context": true}''';
}
