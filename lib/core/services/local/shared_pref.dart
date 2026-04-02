import 'dart:convert';

import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
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

  static Future<void> setToken(String value) async {
    await pref.setString(kToken, value);
  }

  static String? getToken() {
    return pref.getString(kToken);
  }

  static Future<void> setUserInfo(User? model) async {
    if (model == null) {
      return;
    }
    var objToJson = model.toJson();
    var jsonToString = jsonEncode(objToJson);
    await pref.setString(kUser, jsonToString);
  }

  static User? getUserInfo() {
    var cachedString = pref.getString(kUser);
    if (cachedString == null) return null;
    var stringToJson = jsonDecode(cachedString);
    var jsonToObject = User.fromJson(stringToJson);
    return jsonToObject;
  }

  static void cashWishListIds(List<Product> items) {
    var ids = items.map((item) => item.id.toString()).toList();
    cacheData(kWishListIds, ids);
  }

  static List<int> getWishListIds() {
    final ids = pref.getStringList(kWishListIds) ?? [];
    return ids.map((id) => int.tryParse(id) ?? 0).toList();
  }

  static void cashCartListIds(List<CartItem?> items) {
    var ids = items
        .map((item) => item?.itemProductId.toString() ?? '')
        .toList();
    cacheData(kCartListIds, ids);
  }

  static List<int> getCartListIds() {
    final ids = pref.getStringList(kCartListIds) ?? [];
    return ids.map((id) => int.tryParse(id) ?? 0).toList();
  }

  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    }
  }

  static Object getData(String key) {
    return pref.getString(key) ?? "";
  }

  static Future<void> removeData(String key) async {
    await pref.remove(key);
  }

  static Future<void> clear() async {
    await pref.clear();
  }

  static Future<void> setLanguage(String value) async {
    await pref.setString(kLanguage, value);
  }

  static String getLanguage() {
    return pref.getString(kLanguage) ?? "en";
  }
}
