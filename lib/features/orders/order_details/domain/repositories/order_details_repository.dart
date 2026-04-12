import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/orders/order_details/data/models/order_details_response/order_details_response.dart';
import 'package:dartz/dartz.dart';

abstract class OrderDetailsRepository {
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails(int orderId);
}
