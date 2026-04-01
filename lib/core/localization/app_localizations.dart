import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "login": "Login",
      "register": "Register",
      "home": "Home",
      "wishlist": "Wishlist",
      "cart": "Cart",
      "profile": "Profile",
      "order_now": "Order Your Book Now!",
      "no_orders": "No orders yet",
    },
    'ar': {
      "login": "تسجيل الدخول",
      "register": "إنشاء حساب",
      "home": "الرئيسية",
      "wishlist": "المفضلة",
      "cart": "السلة",
      "profile": "حسابي",
      "order_now": "اطلب كتابك الآن!",
      "no_orders": "لا توجد طلبات",
    },
  };

  String tr(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }

 
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_) => false;
}