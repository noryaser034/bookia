import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:bookia/feature/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyles.caption1.copyWith(color: AppColors.blackcolor),
          ),
          GestureDetector(
            onTap: () {
              pushTo(context, const SignUpScreen());
            },
            child: Text(
              "Register Now",
              style: TextStyles.caption1.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
