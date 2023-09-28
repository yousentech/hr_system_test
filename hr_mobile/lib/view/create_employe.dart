import 'package:flutter/material.dart';
import 'package:hr_mobile/widget/button.dart';
import 'package:hr_mobile/widget/dropdownlist.dart';
import 'package:hr_mobile/widget/textfield.dart';
import 'package:hr_mobile/controller/controler.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:get/get.dart';
class create_employee extends StatefulWidget {
  const create_employee({super.key});

  @override
  State<create_employee> createState() => _create_employeeState();
}

class _create_employeeState extends State<create_employee> {
 TextEditingController name =TextEditingController();
 TextEditingController email =TextEditingController();
 TextEditingController phone =TextEditingController();
 var  contoller =Get.put(controller());
 List listofcompny=[];
  getcompany()async{
 var c=await contoller.fetchCompny();
 listofcompny=c;
 print(listofcompny);
 }

  @override
  void initState() {
    getcompany();
    create_employee();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Column(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height/3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/mobailehead2.png"),
                 fit: BoxFit.cover,
                )
              ),
              child: Center(child: Text("انشاء موظف",style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: Colors.white),)),
            ),
            cstom_textfiled(textcontroller:name),
            cstom_textfiled(textcontroller:email),
            cstom_textfiled(textcontroller:phone),
            button(name: name,email: email,phone: phone,)
            // cstom_dropdown(list:listofcompny),
            // cstom_dropdown(list:listofcompny)
          ]),
        ),
      ),
    );
  }
}