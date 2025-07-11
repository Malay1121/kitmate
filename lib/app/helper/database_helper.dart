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
