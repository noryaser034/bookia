import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartScreenBtttomNavBar extends StatelessWidget {
  const CartScreenBtttomNavBar({
    super.key,
    required this.onPressed,
    required this.totalPrice,
    required this.text,
    this.isLoading = false,
  });

  final double totalPrice;
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.translate("total"),
              style: const TextStyle(
                fontFamily: "Nunito Sans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.grayColor,
              ),
            ),
            Text(
              "$totalPrice ${context.translate("price_currency")}",
              style: const TextStyle(
                fontFamily: "Nunito Sans",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Gap(19),
        MainButton(text: text, onPressed: onPressed, isLoading: isLoading),
      ],
    );
  }
}
