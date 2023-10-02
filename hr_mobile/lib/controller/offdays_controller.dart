import 'package:get/get.dart';
import 'package:hr_mobile/controller/login_controller.dart';
import 'package:hr_mobile/model/loan_model.dart';
import 'package:hr_mobile/model/offday_model.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OffdaysController extends GetxController {
  final offdayLoading = false.obs;


  // for session Id in loginController
  final LoginController loginController = Get.find();
  OdooClient get odooClient => loginController.odooClient!;
  
  // create offday
  createOffDay(OffdaysModel offdaysModel) async {
    try {
        offdayLoading.value = true;
        odooClient.callKw({
        'model': 'hrsystem.offdays',
        'method': 'create',
        'args': [
          offdaysModel.toJson()
        ],
        'kwargs': {
        },
      });
      offdayLoading.value = false;
      return true;
    } catch (e) {
      offdayLoading.value = false;
      print(e);
      return false;
    }
  }

  


  
}
