// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ContainerTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType ?keyboardType;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTap;
  final TextEditingController controller;
  const ContainerTextField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType=TextInputType.text,
    this.readOnly = false,
    this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        readOnly:readOnly,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: const UnderlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
        onTap:
          onTap
        ,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "${labelText}Requied Field";
          }
          return null;
        },
      ),
    );
  }
}
