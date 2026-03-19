import 'dart:convert';

import 'package:bookia/feature/auth/data/models/auth_response/user.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/feature/home/data/models/best_seller_books_response/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences pref;

  static const String kToken = 'token';
  static const String kUser = 'user';
  static const String kWishlist = 'wishlistIds';
  static const String kCart = 'cartIds';

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
    // 1) convert object to json
    var objToJson = model.toJson();
    // 2) convert json to string (encode)
    var jsonToString = jsonEncode(objToJson);
    // 3) save string
    await pref.setString(kUser, jsonToString);
  }

  static User? getUserInfo() {
    //1) get string
    var cachedString = pref.getString(kUser);

    if (cachedString == null) {
      return null;
    }
    // 2) convert string to json (decode)
    var stringToJson = jsonDecode(cachedString);
    // 3) convert json to object
    var jsonToObject = User.fromJson(stringToJson);
    return jsonToObject;
  }

  // --- wishlist

  static void cacheWishlistIds(List<Product> items) {
    var ids = items.map((item) => item.id.toString()).toList();
    // cache list of ids
    cacheData(kWishlist, ids);
  }

  static List<int> getWishlistIds() {
    var ids = getData(kWishlist);
    if (ids is List<String>) {
      return ids.map((id) => int.tryParse(id) ?? 0).toList();
    } else {
      return [];
    }
  }

  // --- cart
  static void cacheCartIds(List<CartItem> items) {
    var ids = items.map((item) => item.itemProductId.toString()).toList();
    // cache list of ids
    cacheData(kCart, ids);
  }

  static List<int> getCartIds() {
    var ids = getData(kCart);
    if (ids is List<String>) {
      return ids.map((id) => int.tryParse(id) ?? 0).toList();
    } else {
      return [];
    }
  }

  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    }
  }

  static Object getData(String key) {
    return pref.get(key) ?? '';
  }

  static Future<void> removeData(String key) async {
    await pref.remove(key);
  }

  static Future<void> clear() async {
    await pref.clear();
  }
}

// Memory Management

// token , value
// user , value
