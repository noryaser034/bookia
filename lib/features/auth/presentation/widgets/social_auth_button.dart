import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    this.onTap,
    required this.iconPath,
    required this.text,
  });
  final Function()? onTap;
  final String iconPath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            const Gap(4),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                text,
                style: TextStyles.w400s14.copyWith(color: AppColors.darkGray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
