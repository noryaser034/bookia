import 'package:flutter/material.dart';
import 'package:greenmark/core/functions/validation.dart';
import 'package:greenmark/core/styles/colors.dart';
import 'package:greenmark/core/styles/text_style.dart';

class PhoneTextFormFiled extends StatelessWidget {
  const PhoneTextFormFiled({
    super.key,
    this.hintText = "01xxxxxxxxx",
    this.keyboardType = TextInputType.phone,
    this.controller,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.caption1,
        fillColor: AppColors.accentcolor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validateEgyptPhone,
    );
  }
}
