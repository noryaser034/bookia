import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCartParams {
  final int cartItemId;
  final int quantity;

  UpdateCartParams({required this.cartItemId, required this.quantity});
}

class UpdateCartUseCase implements UseCase<Data, UpdateCartParams> {
  final CartRepository repository;

  UpdateCartUseCase(this.repository);

  @override
  Future<Either<Failure, Data>> call(UpdateCartParams params) {
    return repository.updateCartQuantity(params.cartItemId, params.quantity);
  }
}
