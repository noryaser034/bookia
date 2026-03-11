import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          var cubit = context.read<HomeCubit>();
          var sliders = cubit.sliders;
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: sliders.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          sliders[itemIndex].image ?? '',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 1,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    cubit.onChangeSlider(index);
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Gap(14),
              AnimatedSmoothIndicator(
                activeIndex: cubit.yourActiveIndex,
                count: sliders.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.border,
                  expansionFactor: 4,
                ),
              ),
            ],
          );
        } else {
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
                Gap(14),
                AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    activeDotColor: AppColors.primary,
                    dotColor: AppColors.border,
                    expansionFactor: 4,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}