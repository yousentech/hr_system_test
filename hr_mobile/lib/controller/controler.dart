 import 'package:get/get.dart';
 import 'package:odoo_rpc/odoo_rpc.dart';
 class controller extends GetxController{
  Future<dynamic> fetchCompny() async {
      final odoo = OdooClient("http://20.20.20.174:8069/");
      await odoo.authenticate('demo', 'admin', 'admin');
      return odoo.callKw({
        'model': 'res.company',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {},
          'domain': [],
          'fields': ['id', 'name',],
          'limit': 80,
        },
      });
    }
      Future<dynamic> createemploy(name ,emil,phone) async {
      final odoo = OdooClient("http://20.20.20.174:8069/");
      await odoo.authenticate('demo', 'admin', 'admin');
      return odoo.callKw({
        'model': 'hr.employee',
        'method': 'create',
        'args': [
          {'name':name.toString(),
    'phone':phone.toString() ,
    'work_email':emil.toString() ,}
        ],
        'kwargs': {
          // 'context': {},
          // 'domain': [],
          // 'fields': ['id', 'name',],
          // 'limit': 80,
        },
      });
    }
 }
 