import 'package:bookia/core/styles/text_style.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/home/data/models/best_seller_book_response/poduct.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  final Product product;
  const BookCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.book, size: 50),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? 'Unknown',
                    style: TextStyles.body.copyWith(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(5),
                  Text(
                    product.author ?? '',
                    style: TextStyles.body.copyWith(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(10),
                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: MainButton(
                      text: 'Add to Cart',
                      onpress: () {},
                      backgroundcolor: Colors.black,
                      bordercolor: Colors.black,
                      textStyle: TextStyles.body.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}