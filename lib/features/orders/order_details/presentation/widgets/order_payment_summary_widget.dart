import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/orders/order_details/data/models/order_details_response/data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderPaymentSummaryWidget extends StatelessWidget {
  const OrderPaymentSummaryWidget({super.key, required this.order});

  final Data order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.translate("payment_summary"), style: TextStyles.w400s16),
        const Gap(16),
        _summaryRow(
          title: context.translate("sub_total"),
          value: "${order.subTotal ?? "0"} ${context.translate("price_currency")}",
        ),
        const Gap(10),
        _summaryRow(
          title: context.translate("discount"),
          value: "${order.discount ?? 0} ${context.translate("price_currency")}",
        ),
        const Gap(10),
        _summaryRow(
          title: context.translate("total"),
          value: "${order.total ?? "0"} ${context.translate("price_currency")}",
          isBold: true,
        ),
        const Gap(16),
        _summaryRow(
          title: context.translate("status_label"),
          value: order.status ?? context.translate("unknown"),
        ),
        const Gap(10),
        _summaryRow(
          title: context.translate("date_label"),
          value: order.orderDate ?? "",
        ),
      ],
    );
  }

  Widget _summaryRow({
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: isBold ? TextStyles.w400s16 : TextStyles.w400s14),
        Text(value, style: isBold ? TextStyles.w400s16 : TextStyles.w400s14),
      ],
    );
  }
}
