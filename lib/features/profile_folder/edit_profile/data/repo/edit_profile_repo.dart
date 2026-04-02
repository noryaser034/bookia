import 'dart:developer';
import 'dart:io';

import 'package:bookia/core/services/api/api.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_params.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:dio/dio.dart';

abstract class EditProfileRepo {
  static Future<EditProfileResponse?> editProfile(
    EditProfileParams params, {
    File? image,
  }) async {
    try {
      final token = SharedPref.getToken();

      final formData = FormData.fromMap({
        'name': params.name,
        'phone': params.phone,
        'address': params.address,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      var response = await DioProvider.dio.post(
        Apis.editProfile,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = EditProfileResponse.fromJson(response.data);

        // Update cached user info
        final updatedUser = User(
          id: SharedPref.getUserInfo()?.id,
          name: data.data?.name,
          email: SharedPref.getUserInfo()?.email,
          address: data.data?.address,
          phone: data.data?.phone,
          image: data.data?.image,
          emailVerified: SharedPref.getUserInfo()?.emailVerified,
        );
        await SharedPref.setUserInfo(updatedUser);

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
