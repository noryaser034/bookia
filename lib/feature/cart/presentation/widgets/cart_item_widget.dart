import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    this.onRemove,
    this.onUpdate,
  });

  final CartItem item;
  final Function()? onRemove;
  final Function(int)? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.itemProductImage ?? "",
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.itemProductName}',
                            style: TextStyles.subtitle2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(5),
                          Text(
                            '\$${item.itemProductPriceAfterDiscount}',
                            style: TextStyles.body.copyWith(
                              color: AppColors.darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: onRemove,
                    ),
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        int quantity = item.itemQuantity ?? 0;
                        var updatedCount = quantity - 1;
                        if (quantity > 1) {
                          onUpdate!(updatedCount);
                        } else {
                          showMyDialog(context, 'Cannot remove less than 1');
                        }
                      },
                    ),
                    Text('${item.itemQuantity}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        int quantity = item.itemQuantity ?? 0;
                        var updatedCount = quantity + 1;
                        if (updatedCount <= (item.itemProductStock ?? 0)) {
                          onUpdate!(updatedCount);
                        } else {
                          showMyDialog(context, 'Cannot add more than stock');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
