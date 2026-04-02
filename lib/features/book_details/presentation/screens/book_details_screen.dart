import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:bookia/features/book_details/presentation/widgets/book_details_body.dart';
import 'package:bookia/features/book_details/presentation/widgets/book_details_nav_bar.dart';
import 'package:bookia/features/book_details/presentation/widgets/wish_list_icon.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookDetailsCubit, BookDetailsState>(
      listener: (context, state) {
        if (state is AddToWishListLoadingState ||
            state is AddToCartLoadingState) {
          showLoadingDialog(context);
        } else if (state is AddToWishListSuccessState) {
          pop(context);
          showMyDialog(
            context,
            context.translate("added_to_wishlist"),
            type: DialogType.success,
          );
        } else if (state is AddToWishListErrorState) {
          pop(context);
          showMyDialog(context, context.translate("failed_to_add_to_wishlist"));
        } else if (state is AddToCartSuccessState) {
          pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.translate("added_to_cart"))),
          );
        } else if (state is AddToCartErrorState) {
          pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.translate("failed_to_add_to_cart"))),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<BookDetailsCubit>();
        final isInCart = cubit.isInCart(product.id ?? 0);

        return Scaffold(
          appBar: AppBar(
            title: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: SvgPicture.asset(AppImages.backIconsvg),
            ),
            automaticallyImplyLeading: false,
            actions: [
              WishListIcon(product: product),
              const SizedBox(width: 16),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: BookDetailsBody(product: product),
            ),
          ),
          bottomNavigationBar: BookDetailsNavBar(
            product: product,
            isInCart: isInCart,
            cubit: cubit,
          ),
        );
      },
    );
  }
}
