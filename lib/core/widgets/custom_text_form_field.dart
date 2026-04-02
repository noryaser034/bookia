import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.keyboardType,
    this.validator,
    this.icon,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  final String hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? icon;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.accentColor,
        hintText: hint,
        hintStyle: TextStyles.w400s15.copyWith(color: AppColors.grayColor),
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
