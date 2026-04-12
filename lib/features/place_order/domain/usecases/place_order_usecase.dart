import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/place_order/domain/repositories/place_order_repository.dart';
import 'package:dartz/dartz.dart';

class PlaceOrderParams {
  final int governorateId;
  final String name;
  final String phone;
  final String address;
  final String email;

  PlaceOrderParams({
    required this.governorateId,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });
}

class PlaceOrderUseCase implements UseCase<int?, PlaceOrderParams> {
  final PlaceOrderRepository repository;

  PlaceOrderUseCase(this.repository);

  @override
  Future<Either<Failure, int?>> call(PlaceOrderParams params) {
    return repository.placeOrder(
      governorateId: params.governorateId,
      name: params.name,
      phone: params.phone,
      address: params.address,
      email: params.email,
    );
  }
}
