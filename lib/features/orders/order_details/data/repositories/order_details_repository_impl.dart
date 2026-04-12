import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/orders/order_details/data/data_sources/order_details_remote_data_source.dart';
import 'package:bookia/features/orders/order_details/data/models/order_details_response/order_details_response.dart';
import 'package:bookia/features/orders/order_details/domain/repositories/order_details_repository.dart';
import 'package:dartz/dartz.dart';

class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  final OrderDetailsRemoteDataSource remoteDataSource;

  OrderDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails(
    int orderId,
  ) async {
    final response = await remoteDataSource.getOrderDetails(orderId);
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(OrderDetailsResponse.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
