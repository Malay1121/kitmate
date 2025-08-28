import 'package:kitmate/app/helper/all_imports.dart';

class DatabaseHelper {
  static Future getApis() async {
    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection("apis").doc("apis").get();
      apiKeys = documentSnapshot.data() != null
          ? documentSnapshot.data() as Map
          : apiKeys;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future getOperationStatus() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("operations")
          .doc("operations")
          .get();
      operations = documentSnapshot.data() != null
          ? documentSnapshot.data() as Map
          : operations;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future createUser({required Map<String, dynamic> data}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data["email"], password: generateMd5(data["password"]));
      data.addEntries({"uid": user.user!.uid}.entries);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(data["uid"])
          .set(data);
      print("data: ${data}");
      if (data != {}) writeUserDetails(data);
      print("data: ${readUserDetails()}");

      await SubscriptionManager.loginRevenueCat();

      return user.user;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future? loginUser({required Map<String, dynamic> data}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: getKey(data, ["email"], ""),
              password: generateMd5(getKey(data, ["password"], "")));
      Map<String, dynamic>? userData = (await FirebaseFirestore.instance
              .collection("users")
              .doc(user.user!.uid)
              .get())
          .data();
      if (userData != null) writeUserDetails(userData);
      await SubscriptionManager.loginRevenueCat();
      await SubscriptionManager.syncSubscriptionStatus();
      return user;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future editUser(
      {required String userId, required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update(data);
      editUserDetails(data);
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future getUser({required String userId}) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      return userSnapshot.data();
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future addIngredients(
      {required String userId, required List ingredientsList}) async {
    try {
      bool pro = await SubscriptionManager.isProUser();
      if (!pro &&
          ingredients.length + ingredientsList.length >
              getKey(freeLimitations, ["max_ingredients"], 30)) {
        showSnackbar(
            message: "You need pro to add more than ${getKey(freeLimitations, [
                  "max_ingredients"
                ], 30)} ingredients");
        proPopup();
      }
      WriteBatch batch = FirebaseFirestore.instance.batch();
      CollectionReference ingredientsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("ingredients");
      String created_at = toUtc(DateTime.now());

      for (Map ingredient in ingredientsList) {
        DocumentReference documentReference = ingredientsCollection.doc();
        ingredient.addEntries({
          "id": documentReference.id,
          "created_at": created_at,
        }.entries);
        batch.set(documentReference, ingredient);
      }
      await batch.commit();
      return {"message": "Success"};
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      return null;
    }
  }

  static Future removeIngredients(
      {required String userId, required List<Map> ingredients}) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      CollectionReference ingredientsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("ingredients");

      for (Map ingredient in ingredients) {
        DocumentReference documentReference =
            ingredientsCollection.doc(getKey(ingredient, ["id"], ""));

        batch.delete(documentReference);
      }
      await batch.commit();
      return {"message": "Success"};
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      return null;
    }
  }

  static Future updateIngredientsFromGemini(
      {required String userId,
      required bool add,
      required List ingredients}) async {
    try {
      for (Map ingredient in ingredients) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("ingredients")
            .where("label", isEqualTo: getKey(ingredient, ["label"], ""))
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          String ingredientId = querySnapshot.docs.first.id;
          Map baseIngredient = querySnapshot.docs.first.data() as Map;

          double quantity =
              double.parse(getKey(baseIngredient, ["quantity"], 0).toString())
                  .toDouble();
          if (quantity -
                      double.parse(
                          getKey(ingredient, ["quantity"], 0).toString()) <=
                  0 &&
              !add) {
            removeIngredients(userId: userId, ingredients: [baseIngredient]);
          } else {
            baseIngredient["quantity"] = add
                ? quantity +
                    double.parse(getKey(ingredient, ["quantity"], 0).toString())
                : quantity -
                    double.parse(
                        getKey(ingredient, ["quantity"], 0).toString());
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .collection("ingredients")
                .doc(ingredientId)
                .update(baseIngredient as Map<String, dynamic>);
          }
        } else {
          if (add) {
            addIngredients(userId: userId, ingredientsList: [ingredient]);
          } else {
            showSnackbar(
                message: getKey(ingredient, ["label"], "Ingredient") +
                    " Not found, please update manually.");
          }
        }
      }

      return ingredients;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future updateIngredient(
      {required String userId, required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("ingredients")
          .doc(getKey(data, ["id"], ""))
          .update(data);
      return data;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future updateApiIndex({required String apiName}) async {
    try {
      await FirebaseFirestore.instance
          .collection("apis")
          .doc("apis")
          .update(apiKeys[apiName]);
      return apiKeys[apiName];
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future createTicket(
      {required String userId, required String message}) async {
    try {
      String time = toUtc(DateTime.now());

      WriteBatch batch = FirebaseFirestore.instance.batch();
      CollectionReference ingredientsCollection =
          FirebaseFirestore.instance.collection("tickets");

      DocumentReference doc = ingredientsCollection.doc();
      Map<String, dynamic> ticket = {
        "message": message,
        "user": userId,
        "created_at": time,
        "updated_at": time,
        "id": doc.id,
        "seen": false,
      };

      batch.set(doc, ticket);

      await batch.commit();
      await replyTicket(userId: userId, ticketId: doc.id, message: message);
      return {"message": "Success", "ticket": doc.id};
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      return null;
    }
  }

  static Future replyTicket(
      {required String userId,
      required String ticketId,
      required String message}) async {
    try {
      String time = toUtc(DateTime.now());
      Map<String, dynamic> chat = {
        "message": message,
        "user": userId,
        "created_at": time,
      };
      await FirebaseFirestore.instance
          .collection("tickets")
          .doc(ticketId)
          .collection("chat")
          .add(chat);
      await FirebaseFirestore.instance
          .collection("tickets")
          .doc(ticketId)
          .update({
        "seen": true,
      });
      return {"message": "Success"};
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      return null;
    }
  }

  static Future saveRecipe(
      {required String userId, required Map<String, dynamic> recipe}) async {
    try {
      String createdAt = toUtc(DateTime.now());

      // Add metadata to recipe
      recipe.addEntries({
        "id": FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("saved_recipes")
            .doc()
            .id,
        "saved_at": createdAt,
        "created_at": createdAt,
      }.entries);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("saved_recipes")
          .doc(recipe["id"])
          .set(recipe);

      return {"message": "Success", "recipe_id": recipe["id"]};
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      return null;
    }
  }

  static Future deleteRecipe(
      {required String userId, required String recipeId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("saved_recipes")
          .doc(recipeId)
          .delete();

      return {"message": "Success"};
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      return null;
    }
  }
}
