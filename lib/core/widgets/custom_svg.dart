import 'package:bookia/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    super.key,
    this.color,
    required this.path,
    this.width,
    this.height,
  });
  final String path;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(AppColors.primary, BlendMode.srcIn)
          : null,
    );
  }
}
