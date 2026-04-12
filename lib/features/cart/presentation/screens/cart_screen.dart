import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/shimmer/list_shimmer.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_screen_btttom_nav_bar.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_tile.dart';
import 'package:bookia/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CartCubit>()..getCartItems(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text(context.translate("cart"), style: TextStyles.w400s24),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 50),
              child: () {
                if (state is CartLoadingState && cubit.cartItems.isEmpty) {
                  return const ListShimmer();
                }

                if (state is CartErrorState && cubit.cartItems.isEmpty) {
                  return Center(
                    child: Text(context.translate("failed_to_load_data")),
                  );
                }

                if (cubit.cartItems.isEmpty) {
                  return Center(
                    child: Text(context.translate("no_items_in_cart")),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: cubit.cartItems.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return CartTile(cartItem: cubit.cartItems[index]);
                        },
                      ),
                    ),
                    CartScreenBtttomNavBar(
                      text: context.translate("checkout"),
                      onPressed: () async {
                        final isSuccess = await cubit.checkout();

                        if (!context.mounted) return;

                        if (isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.translate("checkout_success"),
                              ),
                            ),
                          );

                          pushTo(
                            Routes.placeOrder,
                            context,
                            extra: cubit.checkoutData,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.translate("checkout_failed"),
                              ),
                            ),
                          );
                        }
                      },
                      totalPrice: cubit.totalPrice,
                    ),
                  ],
                );
              }(),
            ),
          );
        },
      ),
    );
  }
}
