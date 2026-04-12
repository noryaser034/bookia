import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_params.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_response/reset_password_response.dart';
import 'package:dartz/dartz.dart';

abstract class UpdatePasswordRepository {
  Future<Either<Failure, ResetPasswordResponse>> updatePassword(
    ResetPasswordParams params,
  );
}
