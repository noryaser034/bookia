import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';
import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CheckoutUseCase implements UseCase<CheckoutData, NoParams> {
  final CartRepository repository;

  CheckoutUseCase(this.repository);

  @override
  Future<Either<Failure, CheckoutData>> call(NoParams params) {
    return repository.checkout();
  }
}
