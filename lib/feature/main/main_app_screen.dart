import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/CustomSvg.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/feature/home/presentation/page/home.dart';
import 'package:flutter/material.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    Home(),
    Center(child: Text('Wishlist')),
    Center(child: Text('Cart')),
    Center(child: Text('Profile')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: CustomSvgPicture(path: AppImages.homeSvg),
          activeIcon: CustomSvgPicture(
            path: AppImages.homeSvg,
            color: AppColors.primary,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: CustomSvgPicture(path: AppImages.bookmarkSvg),
          activeIcon: CustomSvgPicture(
            path: AppImages.bookmarkSvg,
            color: AppColors.primary,
          ),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: CustomSvgPicture(path: AppImages.cartSvg),
          activeIcon: CustomSvgPicture(
            path: AppImages.cartSvg,
            color: AppColors.primary,
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: CustomSvgPicture(path: AppImages.profileSvg),
          activeIcon: CustomSvgPicture(
            path: AppImages.profileSvg,
            color: AppColors.primary,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
