import 'dart:developer';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_params.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_response/reset_password_response.dart';

abstract class ResetPasswordRepo {
  static Future<ResetPasswordResponse?> updatePassword(
    ResetPasswordParams params,
  ) async {
    try {
      final token = SharedPref.getToken();

      var response = await DioProvider.post(
        endPoint: Apis.updatePassword,
        data: params.toJson(),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        var data = ResetPasswordResponse.fromJson(response.data);
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
