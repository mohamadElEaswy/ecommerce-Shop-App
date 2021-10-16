import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    required this.validator,
    required this.hintText,
    this.suffixIcon,
    required this.prefixIcon,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function validator;
  final String? hintText;
  final IconData? suffixIcon;
  final IconData prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      validator: (String? value) => validator(value),
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: defaultColor,
        suffixIcon: Icon(suffixIcon),
        prefixIcon: Icon(prefixIcon),
        // enabledBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(color: defaultColor)),
        border: const OutlineInputBorder(borderSide: BorderSide(color: defaultColor),
            borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),),
      ),
    );
  }
}
