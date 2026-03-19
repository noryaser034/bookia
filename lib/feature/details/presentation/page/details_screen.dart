import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cart_icon.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/wishlist_icon.dart';
import 'package:bookia/feature/home/data/models/best_seller_books_response/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailsArg {
  final Product product;
  final String source;
  DetailsArg({required this.product, required this.source});
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.model});
  final Product model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
        actions: [WishlistActionWidget(id: model.id ?? 0)],
      ),
      body: MyBodyView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: model.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    model.image ?? '',
                    width: 180,
                    height: 270,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(11),
              Text(
                model.name ?? '',
                style: TextStyles.headline,
                textAlign: TextAlign.center,
              ),
              Gap(11),
              Text(
                model.category ?? '',
                style: TextStyles.caption1.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(20),
              Text(
                model.description ?? '',
                textAlign: TextAlign.justify,
                style: TextStyles.caption2.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${model.price} \$', style: TextStyles.title),
            CartActionWidget(id: model.id ?? 0),
          ],
        ),
      ),
    );
  }
}
