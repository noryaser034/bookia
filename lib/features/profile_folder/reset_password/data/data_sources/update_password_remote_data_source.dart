import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_params.dart';
import 'package:dartz/dartz.dart';

abstract class UpdatePasswordRemoteDataSource {
  Future<Either<Failure, dynamic>> updatePassword(ResetPasswordParams params);
}

class UpdatePasswordRemoteDataSourceImpl
    implements UpdatePasswordRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> updatePassword(
    ResetPasswordParams params,
  ) async {
    final token = SharedPref.getToken();

    return await DioProvider.postApi(
      endPoint: Apis.updatePassword,
      data: params.toJson(),
      headers: {'Authorization': 'Bearer $token'},
      unwrapData: false,
    );
  }
}
