import 'package:dartz/dartz.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecases/base_usecase.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase implements BaseUseCase<bool, String> {
  final AuthRepository repository;
  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String email) {
    return repository.forgetPassword(email: email);
  }
}