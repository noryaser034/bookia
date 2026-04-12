import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:dartz/dartz.dart';

abstract class PlaceOrderRemoteDataSource {
  Future<Either<Failure, dynamic>> getGovernorates();
  Future<Either<Failure, dynamic>> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  });
}

class PlaceOrderRemoteDataSourceImpl implements PlaceOrderRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> getGovernorates() async {
    return await DioProvider.getApi(
      endPoint: Apis.governorates,
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      unwrapData: true,
    );
  }

  @override
  Future<Either<Failure, dynamic>> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    return await DioProvider.postApi(
      endPoint: Apis.placeOrder,
      data: {
        "governorate_id": governorateId,
        "name": name,
        "phone": phone,
        "address": address,
        "email": email,
      },
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );
  }
}
