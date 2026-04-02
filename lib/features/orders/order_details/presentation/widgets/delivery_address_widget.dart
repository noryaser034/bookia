import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/orders/order_details/data/models/order_details_response/data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key, required this.order});

  final Data order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.translate("delivery_address"), style: TextStyles.w400s16),
        const Gap(12),
        Text(order.name ?? context.translate("no_name"), style: TextStyles.w400s14),
        const Gap(4),
        Text(
          "${order.address ?? ""}, ${order.governorate ?? ""}",
          style: TextStyles.w400s12.copyWith(
            color: AppColors.grayColor,
          ),
        ),
        const Gap(4),
        Text(
          order.phone ?? "",
          style: TextStyles.w400s12.copyWith(
            color: AppColors.grayColor,
          ),
        ),
      ],
    );
  }
}
