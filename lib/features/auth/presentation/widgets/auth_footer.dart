import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.text,
    required this.textButton,
    this.onPressed,
  });
  final String text;
  final String textButton;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: text, style: TextStyles.w400s14),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: TextButton(
                  onPressed: onPressed,
                  child: Text(
                    textButton,
                    style: TextStyles.w400s14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
