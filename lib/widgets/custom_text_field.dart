import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.onChange,
    this.obscureText = false,
  });

  final String hint;
  final void Function(String value) onChange;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
        onChanged: onChange,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            label: Text(
              hint,
              style: const TextStyle(color: Colors.white),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )));
  }
}
