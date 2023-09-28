import 'package:flutter/material.dart';

class cstom_textfiled extends StatefulWidget {
    TextEditingController textcontroller =new TextEditingController() ;
  cstom_textfiled({required this.textcontroller});
  @override
  State<cstom_textfiled> createState() => _cstom_textfiledState();
}

class _cstom_textfiledState extends State<cstom_textfiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TextField(
            controller: widget.textcontroller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),
              hintText: 'اضافه موظف',
            ),
        )
    );
  }

}