import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WishListIcon extends StatelessWidget {
  const WishListIcon({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        var cubit = context.read<BookDetailsCubit>();
        return cubit.isInWishList(product.id ?? 0)
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  cubit.addToWishList(product.id ?? 0);
                },
                icon: SvgPicture.asset(AppImages.bookMarkIconSvg),
              );
      },
    );
  }
}
