import 'dart:developer';
import 'package:bookia/core/services/local/sherd_pref.dart';
import 'package:bookia/feature/auth/data/model/register_response/register_response.dart';
import 'package:bookia/feature/auth/data/model/registerparams.dart';
import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static Future<AuthResponse?> register(Registerparams params) async {
    try {
      log(params.toJson().toString());
      var response = await DioProvider.post(
        endpoint: Apis.register,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        response.data; //jason (map)
        //parse json to model
        var data = AuthResponse.fromJson(response.data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data.data?.token ?? "");

        return data; //return model
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> login(Registerparams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.login,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        response.data;
        var data = AuthResponse.fromJson(response.data);
        await SharedPref.setToken(data.data?.token ?? "");
        SharedPref.setUserInfo(data.data?.user);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> forgotPassword(Registerparams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.login,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        response.data;
        var data = AuthResponse.fromJson(response.data);
        await SharedPref.setToken(data.data?.token ?? "");
        SharedPref.setUserInfo(data.data?.user);

        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
