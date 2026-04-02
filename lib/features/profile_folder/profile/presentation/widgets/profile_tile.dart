import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, this.onTap, required this.title});
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.bgColor,

          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 7),
              blurRadius: 40,
              spreadRadius: 0,
              color: const Color(0xFF8A959E).withValues(alpha: 0.2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.w400s18.copyWith(color: AppColors.black3),
              ),
              SvgPicture.asset(AppImages.forwordIconSvg),
            ],
          ),
        ),
      ),
    );
  }
}
