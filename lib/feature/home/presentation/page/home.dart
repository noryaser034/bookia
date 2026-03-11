import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/CustomSvg.dart';
import 'package:bookia/core/styles/text_style.dart';
import 'package:bookia/feature/home/presentation/widget/home_slider.dart';
import 'package:bookia/feature/home/presentation/widget/best_seller_books.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomSvgPicture(
          path: AppImages.logosvg,
          height: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CustomSvgPicture(
              path: AppImages.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: const [
            HomeSlider(),
            Gap(25),
            Text(
              "Best Seller",
              style: TextStyles.title,
            ),
            Gap(20),
            BestSellerBooks(),
          ],
        ),
      ),
    );
  }
}
