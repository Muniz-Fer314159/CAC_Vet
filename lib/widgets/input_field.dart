import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool obscure;
  final String? Function(String?)? validator;

  const InputField({
    super.key,
    this.obscure = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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