import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/orders/my_orders/data/models/my_orders_response/my_orders_response.dart';
import 'package:bookia/features/orders/my_orders/domain/repositories/my_orders_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrdersUseCase implements UseCase<MyOrdersResponse, NoParams> {
  final MyOrdersRepository repository;

  GetOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, MyOrdersResponse>> call(NoParams params) {
    return repository.getOrders();
  }
}
