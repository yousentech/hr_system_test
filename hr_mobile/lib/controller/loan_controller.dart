import 'package:get/get.dart';
import 'package:hr_mobile/controller/login_controller.dart';
import 'package:hr_mobile/model/loan_model.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanController extends GetxController {
  final loanLoading = false.obs;
  final createLoading = false.obs;
  final journalIdLoading = false.obs;
  final accountStatement = false.obs;
  var getJournalIds = [];
  // var valueEmployee = ''.obs;
  // var selectedEmployee = ''.obs;
  // updatEmployeeId({required RxString employeeId}) {
  //   valueEmployee = employeeId;
  // }
  // selectedEmployeeId({required RxString selectedEmployee}) {
  //   selectedEmployee = selectedEmployee;
  // }

  // for session Id in loginController
  final LoginController loginController = Get.find();
  OdooClient get odooClient => loginController.odooClient!;

  // get employee_id from hr.employee
  getEmployee() async {
    try {
      loanLoading.value = true;
      var employees = odooClient.callKw({
        'model': 'hr.employee',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['emplo_checkbox', '=', 'True']
          ],
          'fields': ['id', 'name'],
        },
      });
      loanLoading.value = false;
      return employees;
    } on OdooException catch (e) {
      loanLoading.value = false;
      print(e);
    }
  }

  // get journal_id from account.journal
  getJournalId() async {
    try {
      journalIdLoading.value = true;
      var journalIds = odooClient.callKw({
        'model': 'account.journal',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            [
              'type',
              'in',
              ['cash', 'bank']
            ]
          ],
          'fields': ['id', 'type'],
        },
      });
      journalIdLoading.value = false;
      getJournalIds = await journalIds;
      update();
      return journalIds;
    } on OdooException catch (e) {
      journalIdLoading.value = false;
      print(e);
    }
  }

  // create Loan
  createLoan(LoanModel loanModel) async {
    print(loanModel);
    try {
      createLoading.value = true;
      odooClient.callKw({
        'model': 'hrsystem.loan',
        'method': 'create',
        'args': [loanModel.toJson()],
        'kwargs': {},
      });
      createLoading.value = false;
      return true;
    } catch (e) {
      createLoading.value = false;
      print(e);
      return false;
    }
  }

  // account statement Loan for one user
  // accountStatementUser(String startData, String endData) async {
  //   try {
  //     accountStatement.value = true;
  //     var allAccount = odooClient.callKw({
  //       'model': 'hrsystem.loan',
  //       'method': 'search_read',
  //       'args': [],
  //       'kwargs': {
  //         'context': {},
  //         'domain': [
  //           ['employee_id', '=', 23],
  //           ['date', '>=', startData],
  //           ['date', '<=', endData]
  //         ],
  //       },
  //     });
  //     accountStatement.value = false;
  //     return allAccount;
  //   } on OdooException catch (e) {
  //     accountStatement.value = false;
  //     print(e);
  //   }
  // }

  //account statement hr.employee for one user
  accountStatementUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var employeeId = prefs.getInt('employee_Id');
    try {
      accountStatement.value = true;
      var employeeData = odooClient.callKw({
        'model': 'hr.employee',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['id', '=', employeeId],
          ],
        },
      });
      accountStatement.value = false;
      return employeeData;
    } catch (e) {
      accountStatement.value = false;
      print(e);
    }
  }

  // Employee details hrsystem.details for one user
  employeeDetails({
    required int detailId,
    required String year,
    required String mounth,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var employeeId = prefs.getInt('employee_Id');
    try {
      var detailIds = odooClient.callKw({
        'model': 'hrsystem.details',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [
            ['emp_master_id', '=', employeeId],
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

  // get_year_selection hrsystem.loan
  getYearSelection() async {
    try {
      var years = odooClient.callKw({
        'model': 'hrsystem.loan',
        'method': 'get_year_selection',
        'args': [],
        'kwargs': {},
      });
      return years;
    } catch (e) {
      print(e);
    }
  }

  // get_month_selection hrsystem.loan
  getMonthSelection() async {
    try {
      var months = odooClient.callKw({
        'model': 'hrsystem.loan',
        'method': 'get_month_selection',
        'args': [],
        'kwargs': {},
      });
      return months;
    } catch (e) {
      print(e);
    }
  }
}
