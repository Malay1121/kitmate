class AppStrings {
  static String appName = "Kitmate";

  static String commonValidation = "Please fill all the details";
  static String emailValidation = "Please enter a valid email";
  static String nameValidation = "Please enter a valid name";

  static String phoneValidation = "Please enter a valid phone number";
  static String lastNameValidation = "Please enter a valid first name";
  static String firstNameValidation = "Please enter a valid last name";
  static String profilePictureValidation =
      "Please select a valid profile picture";
  static String passwordValidation = "Please enter a valid password";
  static String passwordErrorMessage =
      "Minimum 8 characters, at least 1 lower case, at least 1 upper case, at least 1 digit";
  static String ingredientNumberValidation =
      "You need to have at least 5 ingredients to get recipe suggestions";
  static String recipeNotFound =
      "No recipe found with the ingredients, try adding some more ingredients";

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

  static String createAccount = 'Create Account';
  static String weAreHereToHelpYou = 'We are here to help you!';
  static String yourName = 'Your Name';
  static String yourEmail = 'Your Email';
  static String password = 'Password';
  static String or = 'or';
  static String doYouHaveAnAccount = 'Do you have an account ?';
  static String signIn = 'Sign In';
  static String hiWelcomeBack = 'Hi, Welcome Back! ';
  static String dontHaveAnAccountYet = 'Don’t have an account yet?';
  static String signUp = 'Sign up';
  static String hopeYoureDoingFine = 'Hope you’re doing fine.';

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
  static String facingIssues = "Are you facing issues?";
  static String regenerateRecipe = "Regenerate Recipe";
  static String generateRecipe = "Generate Recipe";
  static String startCooking = "Start Cooking";
  static String finish = "Finish";
  static String finishWithoutRemovingIngredients =
      "Finish without removing ingredients";
  static String step = "Step";
  static String exit = "Exit";
  static String settings = "Settings";
  static String writeOrTypeCustomConditions = "Write or type custom conditions";
  static String numberOfDishes = "Number of people(Default 1)";

  static String ingredientsInStock = "Ingredients in stock";
  static String longPressAnIngredientToRemoveIt =
      "Long press an ingredient to remove it";
  static String ingredientBySpeechExample =
      ("Update ingredients by speech: Add/Remove ingredients and its quantity whenever you restock/use ingredients. Make sure to also mention ingredient's amount and unit");
  static String noIngredientsAddedYet = "No ingredients added yet!";
  static String addIngredient = "Add ingredient";
  static String updateIngredient = "Update ingredient";
  static String areYouSureYouWantToRemove = "Are you sure you want to remove";
  static String confirm = "Confirm";
  static String save = "Save";
  static String saveAndRegenerate = "Save & Regenerate";
  static String saveAndGenerate = "Save & Generate";
  static String addIngredientWithSpeech = "Add ingredients with speech";
  static String updateIngredientWithSpeech = "Update ingredients with speech";
  static String ingredientName = "Ingredient name";
  static String quantity = "Quantity";
  static String quantityUnit = "Quantity Unit";
  static String gram = "Gram(g)";
  static String mililiter = "Mililiter(ml)";
  static String pieces = "Pieces(1,2,3,4,...)";

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

  static String ingredientsPrompt =
      '''User will try to add and remove the ingredients that they have at their home and you will have to fetch and organize all the ingredients and return in a structured JSON code. The user would mention the ingredient name, amount of ingredient they have, and the ingredient's unit for example kg, gram, g, kilogram, ml, litre, etc. If they do not specify any unit then consider it as "piece". For example if the user says that they have 1 oven, then they won't specify any unit so you can consider its unit as "pieces" and amount as 1 and the name as Oven. The user will say a lot of ingredients and that won't be structure so you will have to intelligently extract details and also figure out if the user wanted wants to add the ingredient, or remove the ingredient. User might make a mistake and correct it later, so use the correct value that they have said later instead of the wrong one. Also the only units supported in the application is "gram", "milliliter", and "pieces". Pieces will be used where gram and milliliter cannot be used. Convert the kilogram and other units into the ones that are supported. If none is supported then keep it as "pieces"

By add and remove the ingredients, I mean that the user will increase or decrease the ingredient's quantity. You will figure out if the user is adding or removing, for example, if user says I have 1000 ml of milk, then the user is adding. User can also say remove an ingredient from my inventory, for example, 'remove milk', so you will put milk in remove list with quantity of 9999999.
If the user's text doesn't match the context of parameters that the user has asked for, change {"context": false}. Or else give the value and change {"context":true}.
If a particular parameter has not been talked about in the text, then return null in that particular field.

RETURN JUST THE JSON CODE, NOTHING ELSE. 

Example Input: "Umm, I have 4kg wheat 1 oven and 3 litre of milk no wait 2 litre milk"

Example Output: {
  "data": {
    "add": [
      {
        "label": "Wheat",
        "quantity": 4000,
        "quantity_unit": "Gram(g)"
      },
      {
        "label": "Oven",
        "quantity": 1,
        "quantity_unit": "Pieces(1,2,3,4...)"
      },
      {
        "label": "Milk",
        "quantity": 2000,
        "quantity_unit": "Milliliter(ml)"
      },
    ],
    "remove": [{ "label": "", "quantity": 1, "quantity_unit": "Gram(g)" }],
    "update": [{ "label": "", "quantity": 1, "quantity_unit": "Gram(g)" }]
  },
  "context": true
}
''';

  static String dishPrompt = '''
  Suggest a dish that a user can make to eat depending on their preferences(What diet they eat, and what allergies do they have) and ingredients that are available with them. There will be a JSON object that will contain the preferences and ingredients that the user has. The JSON object will also contain a parameter 'servings' that says how many dishes does the user want, so please suggest dishes and ingredients required accordingly. The ingredients will also have its quantity and the unit. For example quantity: 100, quantity_unit: grams, which means the user has 100 grams of that ingredient. Check for the ingredients that the user has specified and provide a best recipe that they can make and is compatible to their preferences. If no ingredients given, you can return any good recipe depending on the preferences or vice versa. If none is provided then give a random recipe. Give a detailed recipe which the user can follow. Also return an image of that dish with the recipe, and a few statistics about the recipe(statistics to include: Energy(k), protein(g)m Carbs(g), Fat(g)), and the statistics should be of per serving, ignoring the 'servings' parameter. 
  If parameter 'current_time' is given with a valid value, then suggest a dish that is suitable for that time of the day, so if the time is in morning so give recipes that are usually eaten for breakfast.
  If parameter 'custom_message' is given with a valid value, then take that custom message into account and suggest recipes accordingly. That custom prompt holds more value than other things like ingredients list, diet, allergies, etc. For example, if the user doesn't have an ingredient in the list but it says that they do have the ingredient in custom message, then prioritize the custom message and give results accordingly. 
  
  IF THE USER HAS AT LEAST 5 INGREDIENTS, then STRICTLY give a recipe that can be made from those ingredients. DO NOT include any other ingredients which they don't have. PLEASE STICK TO THE INGREDIENTS THE USER HAS, DO NOT GIVE RECIPE THAT REQUIRES SOME OTHER INGREDIENTS. ALSO MAKE SURE THE INGREDIENTS HAS SUFFICIENT QUANTITY REQUIRED FOR THE RECIPE.
  

If the user's text doesn't match the context of parameters that the user has asked for, change {"context": false}. Or else give the value and change {"context":true}.
If you find no recipe that can be made with the amount ingredients that the user has, change {"recipe_found": false}. Or else give the value and change {"recipe_found": true}
If a particular parameter has not been talked about in the text, then return null in that particular field.
ALSO THE INGREDIENT'S LABEL YOU RETURN SHOULD BE THE EXACT SAME AS THE LABEL MENTIONED ON "label" PARAMETER OF THE INGREDIENT OF THE LIST IN THE INPUT. 
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
      "label": "Ingredient 1", 
      "quantity_label": "quantity of the ingredient with its unit for example ml/teaspoon/etc",
      "quantity": 1, // Quantity of the ingredient required without a unit, just in numbers. Convert everything to grams, milliliter, and pieces and give quantity number in these units.
      "quantity_unit": "Gram(g)/Milliliter(ml)/Pieces(1,2,3,4...)" // Unit of the quantity required(Only Gram(g), Milliliter(ml), Pieces(1,2,3,4...) allowed. If none applicable, keep it Pieces(1,2,3,4...).
    },
    {
      "label": "Ingredient 2", 
      "quantity_label": "quantity of the ingredient with its unit for example ml/teaspoon/etc",
      "quantity": 1, // Quantity of the ingredient required without a unit, just in numbers. Convert everything to grams, milliliter, and pieces and give quantity number in these units.
      "quantity_unit": "Gram(g)/Milliliter(ml)/Pieces(1,2,3,4...)" // Unit of the quantity required(Only Gram(g), Milliliter(ml), Pieces(1,2,3,4...) allowed. If none applicable, keep it Pieces(1,2,3,4...).
    },
    {
      "label": "Ingredient 3", 
      "quantity_label": "quantity of the ingredient with its unit for example ml/teaspoon/etc",
      "quantity": 1, // Quantity of the ingredient required without a unit, just in numbers. Convert everything to grams, milliliter, and pieces and give quantity number in these units.
      "quantity_unit": "Gram(g)/Milliliter(ml)/Pieces(1,2,3,4...)" // Unit of the quantity required(Only Gram(g), Milliliter(ml), Pieces(1,2,3,4...) allowed. If none applicable, keep it Pieces(1,2,3,4...).
    }
  ],
  "steps": [
    {
      "step_no": 1,
      "ingredients_req": [
        {
          "label": "Ingredient 1", 
          "quantity_label": "quantity of the ingredient with its unit for example ml/teaspoon/etc required in this step",
          "quantity": 1, // Quantity of the ingredient required without a unit, just in numbers. Convert everything to grams, milliliter, and pieces and give quantity number in these units.
          "quantity_unit": "Gram(g)/Milliliter(ml)/Pieces(1,2,3,4...)" // Unit of the quantity required(Only Gram(g), Milliliter(ml), Pieces(1,2,3,4...) allowed. If none applicable, keep it Pieces(1,2,3,4...).
        },
        {
          "label": "Ingredient 2", 
          "quantity_label": "quantity of the ingredient with its unit for example ml/teaspoon/etc required in this step",
          "quantity": 1, // Quantity of the ingredient required without a unit, just in numbers. Convert everything to grams, milliliter, and pieces and give quantity number in these units.
          "quantity_unit": "Gram(g)/Milliliter(ml)/Pieces(1,2,3,4...)" // Unit of the quantity required(Only Gram(g), Milliliter(ml), Pieces(1,2,3,4...) allowed. If none applicable, keep it Pieces(1,2,3,4...).
        },
      ],
      "procedure": "Describe the whole procedure on what to do"
    },
  ],
  "recipe_found": true,
}, "context": true}''';
}
