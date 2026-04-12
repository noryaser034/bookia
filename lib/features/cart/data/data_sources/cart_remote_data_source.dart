import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/dio/api.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:dartz/dartz.dart';

abstract class CartRemoteDataSource {
  Future<Either<Failure, dynamic>> getCartItems();
  Future<Either<Failure, dynamic>> addToCart(int productId);
  Future<Either<Failure, dynamic>> removeFromCart(int cartItemId);
  Future<Either<Failure, dynamic>> updateCartQuantity(
    int cartItemId,
    int quantity,
  );
  Future<Either<Failure, dynamic>> checkout();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @override
  Future<Either<Failure, dynamic>> getCartItems() async {
    return await DioProvider.getApi(
      endPoint: Apis.cart,
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      unwrapData: true,
    );
  }

  @override
  Future<Either<Failure, dynamic>> addToCart(int productId) async {
    return await DioProvider.postApi(
      endPoint: Apis.addToCart,
      data: {"product_id": productId},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );
  }

  @override
  Future<Either<Failure, dynamic>> removeFromCart(int cartItemId) async {
    return await DioProvider.postApi(
      endPoint: Apis.removeFromCart,
      data: {"cart_item_id": cartItemId},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );
  }

  @override
  Future<Either<Failure, dynamic>> updateCartQuantity(
    int cartItemId,
    int quantity,
  ) async {
    return await DioProvider.postApi(
      endPoint: Apis.updateCart,
      data: {"cart_item_id": cartItemId, "quantity": quantity},
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
    );
  }

  @override
  Future<Either<Failure, dynamic>> checkout() async {
    return await DioProvider.getApi(
      endPoint: Apis.checkout,
      headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      unwrapData: true,
    );
  }
}
