import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_cubit.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartActionWidget extends StatelessWidget {
  const CartActionWidget({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartActionCubit(),
      child: BlocConsumer<CartActionCubit, CartActionState>(
        listener: (context, state) {
          if (state is CartActionsSuccessState) {
            pop(context);
            showMyDialog(context, state.msg, type: DialogType.success);
          } else if (state is CartActionsErrorState) {
            pop(context);
            showMyDialog(context, 'Something went wrong');
          } else if (state is CartActionsLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<CartActionCubit>();
          bool isInCart = cubit.isProductInCart(id);
          return MainButton(
            bgColor: isInCart ? AppColors.primaryColor : AppColors.darkColor,
            minWidth: 200,
            text: isInCart ? 'Added to cart' : 'Add to cart',
            onPressed: () {
              if (!cubit.isProductInCart(id)) {
                context.read<CartActionCubit>().addToCart(id);
              }
            },
          );
        },
      ),
    );
  }
}
