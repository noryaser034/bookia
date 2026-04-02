import 'dart:developer';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/forget_password_params.dart';
import 'package:bookia/features/auth/data/models/register_params.dart';
import 'package:bookia/features/auth/data/models/reset_password_params.dart';

abstract class AuthRepo {
  static Future<AuthResponse?> register(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.register,
        data: params.toJson(),
      );

      if (response.statusCode == 201) {
        var data = AuthResponse.fromJson(response.data);
        SharedPref.setToken(data.data?.token ?? "");

        SharedPref.setUserInfo(data.data!.user);
        return data;
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
        endPoint: Apis.login,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        SharedPref.setToken(data.data?.token ?? "");
        SharedPref.setUserInfo(data.data!.user);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> forgetPassword(
    ForgetPasswordParams params,
  ) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.forgetPassword,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> resetPassword(ResetPasswordParams params) async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.resetPassword,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        var data = AuthResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> logout() async {
    try {
      var response = await DioProvider.post(
        endPoint: Apis.logout,
        headers: {
          'Authorization': 'Bearer ${SharedPref.getToken()}',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 401) {
        await SharedPref.clear();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      // Force clear local session if network fails or token is already invalid
      await SharedPref.clear();
      return true;
    }
  }
}
