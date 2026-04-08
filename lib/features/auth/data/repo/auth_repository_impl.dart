import 'package:dartz/dartz.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/network/network_info.dart';
import 'package:bookia/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bookia/features/auth/domain/entities/user.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';
import 'package:bookia/core/services/local/shared_pref.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(ConnectionFailure("No Internet Connection"));
    }
    try {
      final response = await remoteDataSource.register({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      });
      await SharedPref.setToken(response.token);
      await SharedPref.setUserInfo(response.user);
      return Right(response.user as User);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(ConnectionFailure("No Internet Connection"));
    }
    try {
      final response = await remoteDataSource.login({
        'email': email,
        'password': password,
      });
      await SharedPref.setToken(response.token);
      await SharedPref.setUserInfo(response.user);
      return Right(response.user as User);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPassword({required String email}) async {
    if (!await networkInfo.isConnected) {
      return const Left(ConnectionFailure("No Internet Connection"));
    }
    try {
      await remoteDataSource.forgetPassword(email);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(ConnectionFailure("No Internet Connection"));
    }
    try {
      await remoteDataSource.verifyOtp(email, otp);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(ConnectionFailure("No Internet Connection"));
    }
    try {
      await remoteDataSource.resetPassword(email, newPassword);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await remoteDataSource.logout();
      await SharedPref.clear();
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}