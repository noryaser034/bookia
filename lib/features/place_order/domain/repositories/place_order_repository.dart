import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/place_order/data/models/governorates_response/governorate_model.dart';
import 'package:dartz/dartz.dart';

abstract class PlaceOrderRepository {
  Future<Either<Failure, List<GovernorateModel>>> getGovernorates();
  Future<Either<Failure, int?>> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  });
}
