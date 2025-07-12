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
      writeUserDetails(data);
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
              email: data["email"], password: generateMd5(data["password"]));
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
      {required String userId, required List ingredients}) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      CollectionReference ingredientsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("ingredients");
      String created_at = toUtc(DateTime.now());

      for (Map ingredient in ingredients) {
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
      EasyLoading.show();
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

          double quantity = getKey(baseIngredient, ["quantity"], 0).toDouble();
          if (quantity - getKey(ingredient, ["quantity"], 0) <= 0 && !add) {
            removeIngredients(userId: userId, ingredients: [baseIngredient]);
          } else {
            baseIngredient["quantity"] = add
                ? quantity + getKey(ingredient, ["quantity"], 0)
                : quantity - getKey(ingredient, ["quantity"], 0);
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .collection("ingredients")
                .doc(ingredientId)
                .update(baseIngredient as Map<String, dynamic>);
          }
        } else {
          if (add) {
            addIngredients(userId: userId, ingredients: [ingredient]);
          } else {
            showSnackbar(
                message: getKey(ingredient, ["label"], "Ingredient") +
                    " Not found, please update manually.");
          }
        }
      }
      EasyLoading.dismiss();

      return ingredients;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
      EasyLoading.dismiss();
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
}
