import 'package:dartz/dartz.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecases/base_usecase.dart';
import 'package:bookia/features/auth/domain/entities/user.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements BaseUseCase<User, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;
  const LoginParams({required this.email, required this.password});
}