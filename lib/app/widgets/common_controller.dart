import '../helper/all_imports.dart';

Map userDetails = {};
RxList ingredients = [].obs;

class CommonController extends AnonCommonController {
  User? get user {
    User? localUser = FirebaseAuth.instance.currentUser;
    if (localUser == null) {
      logout();
    } else {
      return localUser;
    }
    return null;
  }

  StreamSubscription? userStream;
  StreamSubscription? ingredientsStream;
  var onUserUpdate;

  @override
  void onInit() {
    super.onInit();
    ingredients.listen(
      (p0) => update(),
    );
  }

  @override
  void dispose() {
    userStream?.cancel();
    super.dispose();
  }
}
