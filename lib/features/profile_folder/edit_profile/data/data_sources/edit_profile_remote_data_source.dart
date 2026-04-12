import 'dart:io';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class EditProfileRemoteDataSource {
  Future<Either<Failure, dynamic>> editProfile(
    EditProfileParams params, {
    File? image,
  });
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> editProfile(
    EditProfileParams params, {
    File? image,
  }) async {
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

    return await DioProvider.postApi(
      endPoint: Apis.editProfile,
      data: formData,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      },
      unwrapData: false,
    );
  }
}
