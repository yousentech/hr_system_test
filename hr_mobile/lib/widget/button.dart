import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_mobile/controller/controler.dart';

class button extends StatefulWidget {
  TextEditingController name =new TextEditingController() ;
  TextEditingController email =new TextEditingController() ;
  TextEditingController phone =new TextEditingController() ;

button({required this.name,required this.email ,required this.phone});
  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
     var  contoller =Get.put(controller());
    create_employee()async{
      print(widget.name.text);
    var c=await contoller.createemploy(widget.name.text,widget.email.text,widget.phone.text);
//  listofcompny=c;
//  print(listofcompny);
 }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
            create_employee();
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 20,right: 5,left: 5,bottom: 5),
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
        padding: EdgeInsets.only(right:150),
        child: Text("اضافه")
      ),
    );
  }

}