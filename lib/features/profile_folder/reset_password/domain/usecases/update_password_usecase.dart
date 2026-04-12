import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_params.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_response/reset_password_response.dart';
import 'package:bookia/features/profile_folder/reset_password/domain/repositories/update_password_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePasswordUseCase
    implements UseCase<ResetPasswordResponse, ResetPasswordParams> {
  final UpdatePasswordRepository repository;

  UpdatePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, ResetPasswordResponse>> call(
    ResetPasswordParams params,
  ) {
    return repository.updatePassword(params);
  }
}
