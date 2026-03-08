import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                AppImages.success,
              ),
              const SizedBox(height: 32),
              Text(
                "Password Changed!",
                style: TextStyles.header,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Your password has been changed successfully.",
                style: TextStyles.caption1.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              MainButton(
                text: "Back to Login",
                onpress: () {
                  Navigator.pop(context);
                },
                backgroundcolor: AppColors.primary,
                bordercolor: AppColors.primary,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
