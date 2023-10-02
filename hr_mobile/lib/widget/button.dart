// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:hr_mobile/string/colors.dart';

class ButtonElevated extends StatelessWidget {
  Function()? onPressed;
  String text;
  double minimumSize;

  ButtonElevated({
    Key? key,
    this.onPressed,
    required this.text,
    this.minimumSize=40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child:
      minimumSize==0?
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: shadowColor,
          // minimumSize: const Size.fromHeight(minimumSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed:onPressed ,
        child:Text(
          text,
          textAlign: TextAlign.center,
        ),
      ):
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: shadowColor,
          minimumSize: Size.fromHeight(minimumSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed:onPressed ,
        child:Text(
          text,
          textAlign: TextAlign.center,
        ),
      )
      ,
    );
  }
}
