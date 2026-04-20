import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool obscure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const InputField({
    super.key,
    this.obscure = false,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}