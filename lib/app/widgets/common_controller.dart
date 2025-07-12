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

  bool pro = false;
  void isProUser() async {
    pro = await SubscriptionManager.isProUser();
    update();
  }

  StreamSubscription? userStream;
  StreamSubscription? ingredientsStream;
  var onUserUpdate;

  @override
  void onInit() {
    super.onInit();
    isProUser();
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
