import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/orders/order_details/data/models/order_details_response/order_details_response.dart';
import 'package:bookia/features/orders/order_details/domain/repositories/order_details_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrderDetailsUseCase implements UseCase<OrderDetailsResponse, int> {
  final OrderDetailsRepository repository;

  GetOrderDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, OrderDetailsResponse>> call(int orderId) {
    return repository.getOrderDetails(orderId);
  }
}
