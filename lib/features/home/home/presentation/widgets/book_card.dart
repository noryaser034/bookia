import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  final Product product;
  final bool isInWishList;
  final void Function()? onRemoveFromWishList;
  const BookCard({
    super.key,
    required this.product,
    this.isInWishList = false,
    this.onRemoveFromWishList,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(Routes.bookDetails, context, extra: product);
      },
      child: Hero(
        tag: product.id?.toInt() ?? 0,
        child: Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.network(
                    product.image ?? "",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: Text(product.name ?? "", style: TextStyles.w400s18),
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${product.priceAfterDiscount ?? product.price} ${context.translate("price_currency")}",
                      style: TextStyles.w400s16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  isInWishList
                      ? IconButton(
                          onPressed: onRemoveFromWishList,
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.errorColor,
                          ),
                        )
                      : Container(
                          height: 28,
                          width: 73,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.darkColor,
                          ),
                          child: Center(
                            child: Text(
                              context.translate("buy"),
                              style: TextStyles.w400s14.copyWith(
                                color: AppColors.bgColor,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
