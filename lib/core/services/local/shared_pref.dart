import 'dart:convert';
import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences pref;

  static const String kToken = "token";
  static const String kUser = "user";
  static const String kWishListIds = "wishListIds";
  static const String kCartListIds = "cartListIds";
  static const String kLanguage = "language";

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String value) async => pref.setString(kToken, value);
  static String? getToken() => pref.getString(kToken);

  static Future<void> setUserInfo(User? model) async {
    if (model == null) return;
    await pref.setString(kUser, jsonEncode(model.toJson()));
  }

  static User? getUserInfo() {
    final json = pref.getString(kUser);
    if (json == null) return null;
    return User.fromJson(jsonDecode(json));
  }

  // Wishlist
  static Future<void> cacheWishListIds(List<int> ids) async {
    await pref.setStringList(kWishListIds, ids.map((e) => e.toString()).toList());
  }
  static List<int> getWishListIds() {
    return pref.getStringList(kWishListIds)?.map(int.parse).toList() ?? [];
  }

  // Cart
  static Future<void> cacheCartListIds(List<int> ids) async {
    await pref.setStringList(kCartListIds, ids.map((e) => e.toString()).toList());
  }
  static List<int> getCartListIds() {
    return pref.getStringList(kCartListIds)?.map(int.parse).toList() ?? [];
  }

  static Future<void> setLanguage(String value) async => pref.setString(kLanguage, value);
  static String getLanguage() => pref.getString(kLanguage) ?? "en";

  static Future<void> clear() async => pref.clear();
}