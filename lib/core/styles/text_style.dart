import 'package:bookia/core/styles/colors.dart';
import 'package:flutter/material.dart';

abstract class TextStyles {
  static const TextStyle header = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subtitle = TextStyle(fontSize: 18);
  static const TextStyle body = TextStyle(fontSize: 16);
  static const TextStyle caption1 = TextStyle(fontSize: 14);
  static const TextStyle caption2 = TextStyle(
    fontSize: 12,
    color: AppColors.graycolor,
  );
}
