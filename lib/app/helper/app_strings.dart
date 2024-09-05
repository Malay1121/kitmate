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
  static String facingIssues = "Are you facing issues?";
  static String regenerateRecipe = "Regenerate Recipe";
  static String startCooking = "Start Cooking";
  static String finish = "Finish";
  static String step = "Step";
  static String exit = "Exit";
  static String settings = "Settings";
  static String writeOrTypeCustomConditions = "Write or type custom conditions";

  static String ingredientsInStock = "Ingredients in stock";
  static String longPressAnIngredientToRemoveIt =
      "Long press an ingredient to remove it";
  static String ingredientBySpeechExample =
      ("Add ingredients by speech: Speak the list of ingredients available at your home with its amount and unit. \n Example: Umm, I have 4kg wheat 1 oven and 600 grams of lemon and also salt of 200 gram I also have 500 grams of beetroot I have 5 kg rice 2 litre milk 500 gram cheese 10 potatoes 200 gram onion no wait I have 250 gram of onion");
  static String noIngredientsAddedYet = "No ingredients added yet!";
  static String addIngredient = "Add ingredient";
  static String areYouSureYouWantToRemove = "Are you sure you want to remove";
  static String confirm = "Confirm";
  static String save = "Save";
  static String saveAndRegenerate = "Save & Regenerate";
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

  static String ingredientsPrompt =
      '''User will try to say all the ingredients that they have at theri home and you will have to fetch all the ingredients and return in a structed JSON code. The user would mention the ingredient name, amount of ingredient they have, and the ingredient's unit for example kg, gram, g, kilogram, ml, litre, etc. If they do not specify any unit then consider it as an "item". For example if the user says that they have 1 oven, then they won't specify any unit so you can consider its unit as "item" and amount as 1 and the name as Oven. The user will say a lot of ingredients and that won't be structure so you will have to intelligently extract details. User might make a mistake and correct it later, so use the correct value that they have said later instead of the wrong one. Also the only units supported in the application is "gram", "mililiter", and "items". Items will be used where gram and mililiter cannot be used. Convert the kilogram and other units into the ones that are supported. If none is supported then keep it as "items"

If the user's text doesn't match the context of parameters that the user has asked for, change {"context": false}. Or else give the value and change {"context":true}.
If a particular parameter has not been talked about in the text, then return null in that particular field.

RETURN JUST THE JSON CODE, NOTHING ELSE. 

Example Input: "Umm, I have 4kg wheat 1 oven and 600 grams of lemon and also salt of 200 gram I also have 500 grams of beetroot I have 5 kg rice 2 litre milk 500 gram cheese 10 potatoes 200 gram onion no wait I have 250 gram of onion"

Example Output: {"data": [
{
      "label": "Wheat",
"quantity":4000, 
      "quantity_unit": "Gram(g)" ,
    },
{
      "label": "Oven",
"quantity": 1, 
      "quantity_unit": "Item(1,2,3,4...)" ,
    },{
      "label": "Lemon",
"quantity":600,
      "quantity_unit": "Gram(g)" ,
    },{
      "label": "Salt",
"quantity":200, 
      "quantity_unit": "Gram(g)" ,
    },{
      "label": "Beetroot",
"quantity":500, 
      "quantity_unit": "Gram(g)" ,
    },
{
      "label": "Rice",
"quantity":5000, 
      "quantity_unit": "Gram(g)" ,
    },
{
      "label": "Milk",
"quantity":2000, 
      "quantity_unit": "Mililiter(ml)" ,
    },{
      "label": "Cheese",
"quantity":500, 
      "quantity_unit": "Gram(g)" ,
    },{
      "label": "Potato",
"quantity":10, 
      "quantity_unit": "Item(1,2,3,4,...)" ,
    },{
      "label": "Onion",
"quantity":250, 
      "quantity_unit": "Gram(g)" ,
    },
], "context": true}''';

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
