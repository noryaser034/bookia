import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/orders/order_details/presentation/cubit/order_details_cubit.dart';
import 'package:bookia/features/orders/order_details/presentation/cubit/order_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../widgets/delivery_address_widget.dart';
import '../widgets/order_items_widget.dart';
import '../widgets/order_payment_summary_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final int orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool _isLoadingDialogShown = false;

  void _showLoader() {
    if (_isLoadingDialogShown) return;

    _isLoadingDialogShown = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showLoadingDialog(context);
    });
  }

  void _hideLoader() {
    if (!_isLoadingDialogShown) return;

    _isLoadingDialogShown = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(context),
          icon: SvgPicture.asset(AppImages.backIconsvg),
        ),
        title: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            final orderCode =
                context
                    .read<OrderDetailsCubit>()
                    .orderDetailsResponse
                    ?.data
                    ?.orderCode ??
                widget.orderId.toString();

            return Text(
              context.translate("order_no", replacements: {"id": orderCode}),
              style: TextStyles.w400s16,
            );
          },
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {
          if (state is OrderDetailsLoading) {
            _showLoader();
          } else if (state is OrderDetailsLoaded) {
            _hideLoader();
          } else if (state is OrderDetailsError) {
            _hideLoader();
            showMyDialog(context, context.translate(state.message));
          }
        },
        builder: (context, state) {
          final cubit = context.read<OrderDetailsCubit>();
          final order = cubit.orderDetailsResponse?.data;

          if (state is OrderDetailsLoading && order == null) {
            return const SizedBox.shrink();
          }

          if (state is OrderDetailsError && order == null) {
            return Center(
              child: Text(context.translate("failed_to_load_data")),
            );
          }

          if (order == null) {
            return const SizedBox.shrink();
          }

          final products = order.orderProducts ?? [];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                DeliveryAddressWidget(order: order),
                const Gap(16),
                const Divider(),
                const Gap(16),
                OrderItemsWidget(products: products),
                const Gap(8),
                const Divider(),
                const Gap(16),
                OrderPaymentSummaryWidget(order: order),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: MainButton(
          text: context.translate("my_orders"),
          onPressed: () => pop(context),
        ),
      ),
    );
  }
}
