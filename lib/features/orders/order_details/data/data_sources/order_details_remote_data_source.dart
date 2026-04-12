import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:dartz/dartz.dart';

abstract class OrderDetailsRemoteDataSource {
  Future<Either<Failure, dynamic>> getOrderDetails(int orderId);
}

class OrderDetailsRemoteDataSourceImpl implements OrderDetailsRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> getOrderDetails(int orderId) async {
    final token = SharedPref.getToken();

    return await DioProvider.getApi(
      endPoint: "${Apis.showSingleOrder}/$orderId",
      headers: {'Authorization': 'Bearer $token'},
      unwrapData: false,
    );
  }
}
