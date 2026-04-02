import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum DialogType { error, success }

void showMyDialog(
  BuildContext context,
  String errorMeg, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      backgroundColor: type == DialogType.error
          ? AppColors.errorColor
          : AppColors.primaryColor,
      content: Text(errorMeg),
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.darkColor.withValues(alpha: 0.7),
    builder: (context) => Center(child: Lottie.asset(AppImages.loading)),
  );
}
