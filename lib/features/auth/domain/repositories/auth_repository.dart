import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/auth_response/data.dart';
import 'package:bookia/features/auth/data/models/forget_password_params.dart';
import 'package:bookia/features/auth/data/models/register_params.dart';
import 'package:bookia/features/auth/data/models/reset_password_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Data>> register(RegisterParams params);
  Future<Either<Failure, Data>> login(RegisterParams params);
  Future<Either<Failure, Data>> forgetPassword(ForgetPasswordParams params);
  Future<Either<Failure, AuthResponse>> resetPassword(
    ResetPasswordParams params,
  );
  Future<bool> logout();
}
