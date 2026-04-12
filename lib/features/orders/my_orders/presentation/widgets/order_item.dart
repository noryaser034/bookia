import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String totalAmount;
  final Function()? onTap;
  const OrderItem({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.totalAmount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.translate(
                      "order_id",
                      replacements: {"id": orderNumber},
                    ),
                    style: TextStyles.w400s16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyles.w400s14.copyWith(
                    color: AppColors.grayColor,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${context.translate("total")}: ',
                  style: TextStyles.w400s16.copyWith(
                    color: AppColors.grayColor,
                  ),
                ),
                Text(totalAmount, style: TextStyles.w400s16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
