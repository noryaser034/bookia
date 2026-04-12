import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    try {
      final result = await repository.logout();
      return Right(result);
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
