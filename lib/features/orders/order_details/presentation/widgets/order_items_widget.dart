import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/orders/order_details/data/models/order_details_response/order_product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderItemsWidget extends StatelessWidget {
  const OrderItemsWidget({super.key, required this.products});

  final List<OrderProduct> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.translate("order_items"), style: TextStyles.w400s16),
        const Gap(12),
        ...List.generate(products.length, (index) {
          final item = products[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName ?? "", style: TextStyles.w400s14),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.translate(
                        "qty",
                        replacements: {
                          "qty": (item.orderProductQuantity ?? 0).toString(),
                        },
                      ),
                      style: TextStyles.w400s12.copyWith(
                        color: AppColors.grayColor,
                      ),
                    ),
                    Text(
                      "${item.productTotal ?? "0"} ${context.translate("price_currency")}",
                      style: TextStyles.w400s14,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
