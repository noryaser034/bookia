import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/auth_response/data.dart';
import 'package:bookia/features/auth/data/models/forget_password_params.dart';
import 'package:bookia/features/auth/data/models/register_params.dart';
import 'package:bookia/features/auth/data/models/reset_password_params.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Data>> register(RegisterParams params) async {
    final response = await remoteDataSource.register(params.toJson());
    return response.fold((failure) => Left(failure), (data) {
      try {
        var parsedData = Data.fromJson(data);
        SharedPref.setToken(parsedData.token ?? "");
        SharedPref.setUserInfo(parsedData.user);
        return Right(parsedData);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, Data>> login(RegisterParams params) async {
    final response = await remoteDataSource.login(params.toJson());
    return response.fold((failure) => Left(failure), (data) {
      try {
        var parsedData = Data.fromJson(data);
        SharedPref.setToken(parsedData.token ?? "");
        SharedPref.setUserInfo(parsedData.user);
        return Right(parsedData);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, Data>> forgetPassword(
    ForgetPasswordParams params,
  ) async {
    final response = await remoteDataSource.forgetPassword(params.toJson());
    return response.fold((failure) => Left(failure), (data) {
      try {
        var parsedData = Data.fromJson(data);
        SharedPref.setToken(parsedData.token ?? "");
        SharedPref.setUserInfo(parsedData.user);
        return Right(parsedData);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, AuthResponse>> resetPassword(
    ResetPasswordParams params,
  ) async {
    final response = await remoteDataSource.resetPassword(params.toJson());
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(AuthResponse.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<bool> logout() async {
    final token = SharedPref.getToken() ?? "";
    await remoteDataSource.logout(token);
    // Force clear local session if network fails or token is already invalid
    await SharedPref.clear();
    return true;
  }
}
