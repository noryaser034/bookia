import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/widgets/best_seller_books.dart';
import 'package:bookia/feature/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// Person p = Person()..name = 'Mohamed'..display();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..initLoadData(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: CustomSvgPicture(path: AppImages.logoSvg, height: 30),
          actions: [
            IconButton(
              onPressed: () {},
              icon: CustomSvgPicture(path: AppImages.searchSvg),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                HomeSlider(),
                Gap(30),
                BestSellerBooks(),
                Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// sliders => 600 ms
// best seller books => 1 sec

// in Parallel (sliders, best seller books)  => 1 sec
// sliders , best seller books => 1 sec

// emit success
