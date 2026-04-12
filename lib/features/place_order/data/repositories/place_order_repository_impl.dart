import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/place_order/data/data_sources/place_order_remote_data_source.dart';
import 'package:bookia/features/place_order/data/models/governorates_response/governorate_model.dart';
import 'package:bookia/features/place_order/domain/repositories/place_order_repository.dart';
import 'package:dartz/dartz.dart';

class PlaceOrderRepositoryImpl implements PlaceOrderRepository {
  final PlaceOrderRemoteDataSource remoteDataSource;

  PlaceOrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<GovernorateModel>>> getGovernorates() async {
    final response = await remoteDataSource.getGovernorates();
    return response.fold((failure) => Left(failure), (data) {
      try {
        final List listData = data ?? [];
        return Right(
          listData.map((e) => GovernorateModel.fromJson(e)).toList(),
        );
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, int?>> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    final response = await remoteDataSource.placeOrder(
      governorateId: governorateId,
      name: name,
      phone: phone,
      address: address,
      email: email,
    );
    return response.fold((failure) => Left(failure), (data) {
      try {
        final orderId = data?["id"];
        if (orderId is int) return Right(orderId);
        return Right(int.tryParse(orderId?.toString() ?? ''));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
