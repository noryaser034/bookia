import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GovernoratesBottomSheet extends StatelessWidget {
  const GovernoratesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlaceOrderCubit>();

    return BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
      builder: (context, state) {
        if (state is PlaceOrderGovernoratesLoadingState) {
          return const SizedBox(
            height: 350,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is PlaceOrderGovernoratesErrorState) {
          return SizedBox(
            height: 350,
            child: Center(child: Text(context.translate(state.message))),
          );
        }

        return SafeArea(
          child: SizedBox(
            height: 450,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 16),
                Text(context.translate("select_governorate"),
                    style: TextStyles.w400s24),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: cubit.governorates.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = cubit.governorates[index];

                      return ListTile(
                        title: Text(item.governorateNameEn!),
                        onTap: () {
                          Navigator.pop(context, item);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
