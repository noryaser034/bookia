import 'package:dartz/dartz.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecases/base_usecase.dart';
import 'package:bookia/features/auth/domain/entities/user.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements BaseUseCase<User, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) {
    return repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
    );
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String phone;
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
}