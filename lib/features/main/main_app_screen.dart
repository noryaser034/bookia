import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/screens/cart_screen.dart';
import 'package:bookia/features/home/home/presentation/screens/home_screen.dart';
import 'package:bookia/features/profile_folder/profile/presentation/screens/profile_screen.dart';
import 'package:bookia/features/wish_list/presentation/cubit/wish_list_cubit.dart';
import 'package:bookia/features/wish_list/presentation/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.initialIndex = 0});
  final int initialIndex;
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  List<Widget> screens = [
    const HomeScreen(),
    BlocProvider(
      create: (context) => WishListCubit()..getWishList(),
      child: const WishlistScreen(),
    ),
    BlocProvider(
      create: (context) => CartCubit()..getCartItems(),
      child: const CartScreen(),
    ),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _navBar(),
      body: screens[selectedIndex],
    );
  }

  BottomNavigationBar _navBar() {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.darkGray,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.homeIconSvg),
          activeIcon: SvgPicture.asset(
            AppImages.homeIconSvg,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: context.translate("home"),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.bookMarkIconSvg),
          activeIcon: SvgPicture.asset(
            AppImages.bookMarkIconSvg,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: context.translate("wishlist"),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.cartIconSvg),
          activeIcon: SvgPicture.asset(
            AppImages.cartIconSvg,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: context.translate("cart"),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.profileIconSvg),
          activeIcon: SvgPicture.asset(
            AppImages.profileIconSvg,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: context.translate("profile"),
        ),
      ],
    );
  }
}
