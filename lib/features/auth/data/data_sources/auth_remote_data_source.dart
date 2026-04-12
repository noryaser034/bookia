import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, dynamic>> register(Map<String, dynamic> data);
  Future<Either<Failure, dynamic>> login(Map<String, dynamic> data);
  Future<Either<Failure, dynamic>> forgetPassword(Map<String, dynamic> data);
  Future<Either<Failure, dynamic>> resetPassword(Map<String, dynamic> data);
  Future<Either<Failure, dynamic>> logout(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> register(Map<String, dynamic> data) async {
    return await DioProvider.postApi(endPoint: Apis.register, data: data);
  }

  @override
  Future<Either<Failure, dynamic>> login(Map<String, dynamic> data) async {
    return await DioProvider.postApi(endPoint: Apis.login, data: data);
  }

  @override
  Future<Either<Failure, dynamic>> forgetPassword(
    Map<String, dynamic> data,
  ) async {
    return await DioProvider.postApi(endPoint: Apis.forgetPassword, data: data);
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(
    Map<String, dynamic> data,
  ) async {
    return await DioProvider.postApi(
      endPoint: Apis.resetPassword,
      data: data,
      unwrapData: false,
    );
  }

  @override
  Future<Either<Failure, dynamic>> logout(String token) async {
    return await DioProvider.postApi(
      endPoint: Apis.logout,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
