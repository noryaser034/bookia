import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, dynamic>> getSliders();
  Future<Either<Failure, dynamic>> getBestSellerProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> getSliders() async {
    return await DioProvider.getApi(endPoint: Apis.sliders, unwrapData: true);
  }

  @override
  Future<Either<Failure, dynamic>> getBestSellerProducts() async {
    return await DioProvider.getApi(
      endPoint: Apis.productsBestSeller,
      unwrapData: true,
    );
  }
}
