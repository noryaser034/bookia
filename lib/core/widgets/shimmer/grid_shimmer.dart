import 'package:bookia/core/widgets/shimmer/book_card_shimmer.dart';
import 'package:flutter/material.dart';

class GridShimmer extends StatelessWidget {
  const GridShimmer({
    super.key,
    this.itemCount = 4,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.65,
    this.crossAxisSpacing = 15,
    this.mainAxisSpacing = 15,
  });

  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const BookCardShimmer();
      },
    );
  }
}
