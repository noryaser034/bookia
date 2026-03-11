import 'dart:convert';
import 'package:bookia/feature/auth/data/model/register_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences pref;

  static const String kToken = 'token';
  static const String kUser = 'user';

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
