import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveFromCartUseCase implements UseCase<bool, int> {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(int params) {
    return repository.removeFromCart(params);
  }
}
