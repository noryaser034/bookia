import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookDetailsBody extends StatelessWidget {
  const BookDetailsBody({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(30),
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Hero(
            tag: product.id?.toInt() ?? 0,
            child: Image.network(product.image ?? '', height: 270),
          ),
        ),
        const Gap(10),
        Text(product.name ?? 'Unknown Title', style: TextStyles.w400s30),
        const Gap(10),
        Text(
          product.category ?? 'Unknown Author',
          style: TextStyles.w400s30.copyWith(color: AppColors.primaryColor),
        ),
        const Gap(16),
        Text(
          product.description ?? "No description available.",
          style: TextStyles.w400s12,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
