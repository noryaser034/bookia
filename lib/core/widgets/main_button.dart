import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 55),
        foregroundColor: AppColors.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: color != AppColors.primaryColor
              ? const BorderSide(color: AppColors.darkColor, width: 1)
              : BorderSide.none,
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(
              text,
              style: TextStyles.w400s15.copyWith(
                color: color != AppColors.primaryColor
                    ? AppColors.darkColor
                    : AppColors.bgColor,
              ),
            ),
    );
  }
}
