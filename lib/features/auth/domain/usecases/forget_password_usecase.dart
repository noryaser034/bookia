import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/auth/data/models/auth_response/data.dart';
import 'package:bookia/features/auth/data/models/forget_password_params.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUseCase implements UseCase<Data, ForgetPasswordParams> {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, Data>> call(ForgetPasswordParams params) {
    return repository.forgetPassword(params);
  }
}
