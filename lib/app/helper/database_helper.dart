import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/helper/utils.dart';

class DatabaseHelper {
  static Future getApis() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("api_key")
          .doc("api_key")
          .get();
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
      {required User user, required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update(data);
      editUserDetails(data);
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future getUser({required User user}) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      return userSnapshot.data();
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }

  static Future updateIngredient(
      {required User user, required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update(data);
      return data;
    } on FirebaseException catch (error) {
      showFirebaseError(error.message);
    }
  }
}
