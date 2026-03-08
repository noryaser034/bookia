import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordTextFormFiled extends StatefulWidget {
  const PasswordTextFormFiled({
    super.key,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextFormFiled> createState() => _PasswordTextFormFiledState();
}

class _PasswordTextFormFiledState extends State<PasswordTextFormFiled> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyles.caption1.copyWith(color: AppColors.graycolor),
        fillColor: AppColors.accentcolor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: obscureText
              ? const Icon(Icons.visibility_off, color: Colors.grey)
              : SvgPicture.asset(
                  AppImages.eye,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
        ),
      ),
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
    );
  }
}
