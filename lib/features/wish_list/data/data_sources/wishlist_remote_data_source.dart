import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRemoteDataSource {
  Future<Either<Failure, dynamic>> getWishlist();
  Future<Either<Failure, dynamic>> addToWishlist(int productId);
  Future<Either<Failure, dynamic>> removeFromWishlist(int productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> getWishlist() async {
    return await DioProvider.getApi(
      endPoint: Apis.wishlist,
      queryParameters: {"page": 1},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      unwrapData: false,
    );
  }

  @override
  Future<Either<Failure, dynamic>> addToWishlist(int productId) async {
    return await DioProvider.postApi(
      endPoint: Apis.addToWishlist,
      queryParameters: {"page": 1},
      data: {"product_id": productId},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      unwrapData: false,
    );
  }

  @override
  Future<Either<Failure, dynamic>> removeFromWishlist(int productId) async {
    return await DioProvider.postApi(
      endPoint: Apis.removeFromWishlist,
      data: {"product_id": productId},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      queryParameters: {"page": 1},
      unwrapData: false,
    );
  }
}
