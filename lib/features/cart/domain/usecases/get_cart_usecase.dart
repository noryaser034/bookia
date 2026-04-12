import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetCartUseCase implements UseCase<Data, NoParams> {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  @override
  Future<Either<Failure, Data>> call(NoParams params) {
    return repository.getCartItems();
  }
}
