import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/orders/my_orders/presentation/cubit/my_order_cubit.dart';
import 'package:bookia/features/orders/my_orders/presentation/cubit/my_orders_state.dart';
import 'package:bookia/features/orders/my_orders/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyOrderCubit>().getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate("my_orders"), style: TextStyles.w400s20),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(AppImages.backIconsvg),
          onPressed: () => pop(context),
        ),
      ),
      body: BlocConsumer<MyOrderCubit, MyOrdersState>(
        listener: (context, state) {
          if (state is MyOrdersLoading) {
            showLoadingDialog(context);
          } else if (state is MyOrdersLoaded) {
            pop(context);
          } else if (state is MyOrdersError) {
            pop(context);
            showMyDialog(context, context.translate(state.message));
          }
        },
        builder: (context, state) {
          var cubit = context.read<MyOrderCubit>();
          var orders = cubit.myOrdersResponse?.data?.orders;

          if (orders != null && orders.isEmpty) {
            return Center(child: Text(context.translate("no_orders")));
          }

          if (orders != null) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderItem(
                    orderNumber: orders[index].orderCode ?? "N/A",
                    date: orders[index].orderDate ?? "N/A",
                    totalAmount:
                        "${orders[index].total ?? "0"} ${context.translate("price_currency")}",
                    onTap: () {
                      pushTo(
                        Routes.orderDetails,
                        context,
                        extra: orders[index].id,
                      );
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
