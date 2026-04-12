import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/reset_password_params.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase
    implements UseCase<AuthResponse, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(ResetPasswordParams params) {
    return repository.resetPassword(params);
  }
}
