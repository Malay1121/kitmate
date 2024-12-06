import 'package:kitmate/app/widgets/anon_common_controller.dart';

import '../helper/all_imports.dart';

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

  Future<Map?> get userDetails async {
    return await DatabaseHelper.getUser(user: user!);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
