import 'dart:developer';

import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/auth/data/models/auth_response/register_response.dart';
import 'package:bookia/feature/auth/data/models/register_params.dart';

class AuthRepo {
  static Future<AuthResponse?> register(RegisterParams params) async {
    try {
      log(params.toJson().toString());
      var response = await DioProvider.post(
        endpoint: Apis.register,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        // json (Map)
        // parse from json to model
        var data = AuthResponse.fromJson(response.data);
        SharedPref.setToken(data.data?.token ?? '');
        SharedPref.setUserInfo(data.data?.user);
        return data;
        // return model
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> login(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.login,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        SharedPref.setToken(data.data?.token ?? '');
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

//
