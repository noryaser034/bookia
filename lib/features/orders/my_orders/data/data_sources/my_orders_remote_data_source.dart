import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:dartz/dartz.dart';

abstract class MyOrdersRemoteDataSource {
  Future<Either<Failure, dynamic>> getOrders();
}

class MyOrdersRemoteDataSourceImpl implements MyOrdersRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> getOrders() async {
    final token = SharedPref.getToken();
    return await DioProvider.getApi(
      endPoint: Apis.myOrders,
      headers: {'Authorization': 'Bearer $token'},
      unwrapData: false,
    );
  }
}
