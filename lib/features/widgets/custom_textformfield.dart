import 'package:flutter/material.dart';

class CustomTextform extends StatelessWidget {
  const CustomTextform({
    super.key,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.decoration,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
  });

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? labelText;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: SizedBox(
        height: 46,
        child: TextFormField(
          keyboardType: keyboardType ?? TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,

         
          style: const TextStyle(
            color: Color.fromARGB(255, 92, 88, 88),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),

          decoration: InputDecoration(
            labelText: labelText,

   
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 92, 88, 88),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),

            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
          ),
        ),
      ),
    );
  }
}
