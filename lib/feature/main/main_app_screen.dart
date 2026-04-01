import 'package:flutter/material.dart';
import 'package:bookia/core/localization/app_localizations.dart';

import '../home/presentation/page/home_screen.dart';
import '../wishlist/presentation/page/wishlist_screen.dart';
import '../cart/presentation/page/cart_screen.dart';
import '../profile/presentation/page/profile_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);

    return Scaffold(
      body: _getScreen(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: loc.tr("home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: loc.tr("wishlist"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: loc.tr("cart"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: loc.tr("profile"),
          ),
        ],
      ),
    );
  }

  Widget _getScreen() {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const WishlistScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}
