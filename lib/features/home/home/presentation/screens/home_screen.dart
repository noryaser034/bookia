import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/cubits/app_cubit/app_cubit.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/shimmer/grid_shimmer.dart';
import 'package:bookia/core/widgets/shimmer/text_shimmer.dart';
import 'package:bookia/features/home/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:bookia/features/home/home/presentation/cubits/home_cubit/home_state.dart';
import 'package:bookia/features/home/home/presentation/widgets/book_card.dart';
import 'package:bookia/features/home/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        Future.microtask(() => cubit.getHomeData());
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<AppCubit>().changeLanguage();
            },
            icon: const Icon(Icons.language),
          ),
          title: SvgPicture.asset(AppImages.logoSvg, height: 30),
          titleSpacing: 13,
          actions: [
            IconButton(
              onPressed: () {
                pushTo(Routes.search, context);
              },
              icon: SvgPicture.asset(AppImages.searchSvg),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeSlider(),
                    const Gap(31),

                    if (state is HomeSuccessState) ...[
                      Text(context.translate("best_seller"),
                          style: TextStyles.w400s24),
                      const Gap(15),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 11,
                          mainAxisSpacing: 11,
                          childAspectRatio: 0.5,
                        ),
                        itemBuilder: (context, index) {
                          return BookCard(product: state.products[index]);
                        },
                        itemCount: state.products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ] else
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextShimmer(width: 100, height: 50),
                          Gap(30),
                          GridShimmer(
                            crossAxisCount: 2,
                            crossAxisSpacing: 11,
                            mainAxisSpacing: 11,
                            childAspectRatio: 0.5,
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
