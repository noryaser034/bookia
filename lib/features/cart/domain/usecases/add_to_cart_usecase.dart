import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class AddToCartUseCase implements UseCase<Data, int> {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  @override
  Future<Either<Failure, Data>> call(int params) {
    return repository.addToCart(params);
  }
}
