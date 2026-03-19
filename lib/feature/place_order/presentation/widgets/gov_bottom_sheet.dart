import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/feature/place_order/data/models/governorate.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void showGovernorateBottomSheet(
  BuildContext context,
  List<Governorate> governorates,
  Function(Governorate) onSelected,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(16),
          Text('Select Governorate', style: TextStyles.title),
          const Gap(16),
          Expanded(
            child: ListView.separated(
              itemCount: governorates.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final governorate = governorates[index];
                return ListTile(
                  title: Text(
                    governorate.governorateNameEn ?? '',
                    style: TextStyles.body,
                  ),
                  onTap: () {
                    onSelected(governorate);
                    pop(context);
                  },
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
