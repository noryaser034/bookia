import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/shimmer/slider_shimmer.dart';
import 'package:bookia/features/home/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:bookia/features/home/home/presentation/cubits/home_cubit/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

int activeIndex = 0;

class _HomeSliderState extends State<HomeSlider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeErrorState) {
          return SizedBox(
            height: 180,
            child: Center(child: Text(context.translate(state.errorMsg))),
          );
        }

        if (state is HomeSuccessState) {
          final sliders = state.sliders;

          if (sliders.isEmpty) {
            return SizedBox(
              height: 180,
              child: Center(child: Text(context.translate("no_products_found"))),
            );
          }

          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: sliders.length,
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      sliders[itemIndex].image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: const Center(child: Icon(Icons.broken_image)),
                        );
                      },
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 1,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
              ),
              const Gap(14),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: sliders.length,
                effect: const ExpandingDotsEffect(
                  dotColor: AppColors.borderColor,
                  activeDotColor: AppColors.primaryColor,
                ),
              ),
            ],
          );
        }

        return const SliderShimmer();
      },
    );
  }
}
