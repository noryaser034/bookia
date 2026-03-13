import 'package:bookia/core/router/router.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              context.push(Routes.register);
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