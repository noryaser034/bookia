import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/auth/data/models/auth_response/data.dart';
import 'package:bookia/features/auth/data/models/register_params.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements UseCase<Data, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, Data>> call(RegisterParams params) {
    return repository.register(params);
  }
}
