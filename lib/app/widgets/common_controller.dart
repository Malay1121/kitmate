import 'dart:async';

import '../helper/all_imports.dart';

Map userDetails = {};

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
  var onUserUpdate;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    userStream?.cancel();
    super.dispose();
  }
}
