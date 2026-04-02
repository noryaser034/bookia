import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:flutter/material.dart';

class BookDetailsNavBar extends StatelessWidget {
  const BookDetailsNavBar({
    super.key,
    required this.product,
    required this.isInCart,
    required this.cubit,
  });

  final Product product;
  final bool isInCart;
  final BookDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${product.priceAfterDiscount ?? product.price ?? 0} ${context.translate("price_currency")}",
            style: TextStyles.w400s24,
          ),
          isInCart
              ? Text(
                  context.translate("already_in_cart"),
                  style: TextStyles.w400s14.copyWith(
                    color: AppColors.primaryColor,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    cubit.addToCart(product.id ?? 0);
                  },
                  child: Container(
                    height: 56,
                    width: 212,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.darkColor,
                    ),
                    child: Center(
                      child: Text(
                        context.translate("add_to_cart"),
                        style: TextStyles.w400s14.copyWith(
                          color: AppColors.bgColor,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
