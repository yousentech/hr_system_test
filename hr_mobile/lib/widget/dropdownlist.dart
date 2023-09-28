import 'package:flutter/material.dart';
import 'package:hr_mobile/controller/controler.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:get/get.dart';
import 'package:hr_mobile/controller/controler.dart';
class cstom_dropdown extends StatefulWidget {
  List list ;
  cstom_dropdown({required this.list});

  @override
  State<cstom_dropdown> createState() => _cstom_dropdownState();
}

class _cstom_dropdownState extends State<cstom_dropdown> {
  TextEditingController value =TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
                color: const Color.fromARGB(255, 242, 241, 241),
                width: 2.0,
              ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 154, 57, 204),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 7), // changes the shadow position
                ),
              ],
      ),
      padding: EdgeInsets.only(right:25),
      child: PopupMenuButton(
        itemBuilder: (BuildContext context){
          return widget.list.map((item){
            return PopupMenuItem<String>(
              onTap: (){},
              child: Text(item['name']),
              value: item['id'].toString(),
              );
          }).toList();
        },
        child: Center(child: Text("اختر الشركه", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),)),
        )
    );
  }
}