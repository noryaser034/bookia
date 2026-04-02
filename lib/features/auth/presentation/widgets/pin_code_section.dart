import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinCodeSection extends StatelessWidget {
  const PinCodeSection({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: 6,
      focusedPinTheme: PinTheme(
        height: 60,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          border: Border.all(
            style: BorderStyle.solid,
            color: AppColors.primaryColor,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      submittedPinTheme: PinTheme(
        height: 60,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          border: Border.all(
            style: BorderStyle.solid,
            color: AppColors.primaryColor,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyles.w400s24,
      ),
    );
  }
}
