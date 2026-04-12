import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRemoteDataSource {
  Future<Either<Failure, dynamic>> getAllProducts();
  Future<Either<Failure, dynamic>> searchProducts({required String name});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> getAllProducts() async {
    return await DioProvider.getApi(
      endPoint: Apis.allProducts,
      unwrapData: true,
    );
  }

  @override
  Future<Either<Failure, dynamic>> searchProducts({
    required String name,
  }) async {
    return await DioProvider.getApi(
      endPoint: Apis.productsSearch,
      queryParameters: {"name": name},
      unwrapData: true,
    );
  }
}
