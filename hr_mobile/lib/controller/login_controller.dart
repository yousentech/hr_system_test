import 'package:get/get.dart';
import 'package:hr_mobile/model/login_model.dart';
import 'package:hr_mobile/string/string.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class LoginController extends GetxController {
  final authenticateLoading = false.obs;
  OdooClient? odooClient;
  Future authenticate(LoginModel loginModel) async {
    try {
      authenticateLoading.value = true;
      odooClient = OdooClient(url);
      await odooClient!
          .authenticate(loginModel.db, loginModel.login, loginModel.password);
      authenticateLoading.value = false;
      return true;
    } catch (e) {
      authenticateLoading.value = false;
      return false;
    }
  }

  get() async {
    try {
      await odooClient!.authenticate('mydb', 'admin', 'admin');
      var user = odooClient!.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['id', '=', 2]
          ],
          'fields': ['groups_id'],
        },
      });

      return user;
    } on OdooException catch (e) {
      print(e);
    }
  }
}
