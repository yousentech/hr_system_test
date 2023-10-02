import 'package:get/get.dart';
import 'package:hr_mobile/controller/login_controller.dart';
import 'package:hr_mobile/model/employee_model.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeController extends GetxController {
  final employeeLoading = false.obs;

  // for session Id in loginController
  final LoginController loginController = Get.find();
  OdooClient get odooClient => loginController.odooClient!;

  // createEmployee from hr.employee
  createEmployee({required EmployeesModel createEmployee}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      employeeLoading.value = true;
      var create = await odooClient.callKw({
        'model': 'hr.employee',
        'method': 'create',
        'args': [createEmployee.toJson()],
        'kwargs': {},
      });
      prefs.setInt('employee_Id', create);
      employeeLoading.value = false;
      return true;
    } catch (e) {
      employeeLoading.value = false;
      print(e);
      return false;
    }
  }

  allemployeesDetails({
    required String year,
    required String mounth,
  }) async {
    try {
      var detailIds = odooClient.callKw({
        'model': 'hrsystem.details',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['year', '=', year],
            ['mounth', '=', mounth],
          ],
        },
      });
      return detailIds;
    } catch (e) {
      print(e);
    }
  }
}
