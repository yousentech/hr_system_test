import 'package:get/get.dart';
import 'package:hr_mobile/model/login_model.dart';
import 'package:hr_mobile/string/string.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class LoginController extends GetxController {
  final authenticateLoading = false.obs;
  final orpc = OdooClient(url);
  // final count = 0.obs;
  // increment() => count.value++;
  Future authenticate(LoginModel loginModel) async {
    try {
      authenticateLoading.value = true;
      await orpc.authenticate(
          loginModel.db, loginModel.login, loginModel.password);
      authenticateLoading.value = false;
      print("orpc.sessionId;");
      print(orpc.sessionId);
      return true;
    } on OdooException catch (e) {
      authenticateLoading.value = false;
      print(e);
      return false;
    }
  }

  get() async {
    try {
      await orpc.authenticate('mydb', 'admin', 'admin');
      print(" orpc.checkSession();");
      print(orpc.checkSession());
      print("orpc.sessionId;");
      print(orpc.sessionId);
      var user = orpc.callKw({
        'model': 'res.users',
        'method': 'read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': ['id', '=', 2],
          'fields': ['groups_id'],
        },
      });
      return user;
    } on OdooException catch (e) {
      print("e");
      print(e);
    }
  }
}
