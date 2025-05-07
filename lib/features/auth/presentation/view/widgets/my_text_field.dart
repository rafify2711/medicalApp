import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';

import '../../../../../core/utils/app_style.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon,),
        prefixIconColor: AppColors.primary1,
        filled: true,
        fillColor: const Color(0xFFE9F6FE),
        hintText: label,
        hintStyle: AppStyle.bodyCyanTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w100,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
