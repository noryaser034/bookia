import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:bookia/feature/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Already have an account? ",
              style: TextStyles.caption1.copyWith(color: AppColors.blackcolor),
            ),

            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: TextButton(
                onPressed: () {
                  pushReplacement(context, const LoginScreen());
                },
                child: Text(
                  "Login",
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
