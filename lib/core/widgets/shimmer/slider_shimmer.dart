import 'package:bookia/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          const Gap(14),
          const AnimatedSmoothIndicator(
            activeIndex: 0,
            count: 3,
            effect: ExpandingDotsEffect(
              dotHeight: 7,
              dotWidth: 7,
              activeDotColor: AppColors.primaryColor,
              dotColor: AppColors.borderColor,
              expansionFactor: 4,
            ),
          ),
        ],
      ),
    );
  }
}
