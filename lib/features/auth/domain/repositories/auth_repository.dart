import 'package:dartz/dartz.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> forgetPassword({required String email});

  Future<Either<Failure, bool>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, bool>> resetPassword({
    required String email,
    required String newPassword,
  });

  Future<Either<Failure, bool>> logout();
}