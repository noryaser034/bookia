import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showErrorDialog(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(10),
      backgroundColor: AppColors.errorcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(error),
    ),
  );
}

// ignore: non_constant_identifier_names
void ShowLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: AppColors.primary.withValues(alpha: .5),
    builder: (context) => Lottie.asset(AppImages.loading),
  );
}
