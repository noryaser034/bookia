import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/orders/my_orders/data/models/my_orders_response/my_orders_response.dart';
import 'package:dartz/dartz.dart';

abstract class MyOrdersRepository {
  Future<Either<Failure, MyOrdersResponse>> getOrders();
}
