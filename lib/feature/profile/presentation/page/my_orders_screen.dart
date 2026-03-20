import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomBackButton(),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: MyBodyView(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();
            if (state is GetOrdersLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Orders', style: TextStyles.headline),
                const SizedBox(height: 24),
                cubit.orders.isEmpty
                    ? const Center(child: Text('No orders yet'))
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.orders.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = cubit.orders[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order No${order.id}',
                                    style: TextStyles.subtitle1,
                                  ),
                                  Text(
                                    order.createdAt,
                                    style: TextStyles.body
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Total Amount: \$${order.total}',
                                  style: TextStyles.subtitle1,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}