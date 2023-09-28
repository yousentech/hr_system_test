import 'package:flutter/material.dart';

class ContainerTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const ContainerTextField({
    super.key,
    this.prefixIcon,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: const UnderlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
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