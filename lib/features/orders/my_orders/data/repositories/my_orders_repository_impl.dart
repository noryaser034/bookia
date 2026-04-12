import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/orders/my_orders/data/data_sources/my_orders_remote_data_source.dart';
import 'package:bookia/features/orders/my_orders/data/models/my_orders_response/my_orders_response.dart';
import 'package:bookia/features/orders/my_orders/domain/repositories/my_orders_repository.dart';
import 'package:dartz/dartz.dart';

class MyOrdersRepositoryImpl implements MyOrdersRepository {
  final MyOrdersRemoteDataSource remoteDataSource;

  MyOrdersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MyOrdersResponse>> getOrders() async {
    final response = await remoteDataSource.getOrders();
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(MyOrdersResponse.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
