import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';
import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Data>> getCartItems() async {
    final response = await remoteDataSource.getCartItems();
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(Data.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, Data>> addToCart(int productId) async {
    final response = await remoteDataSource.addToCart(productId);
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(Data.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> removeFromCart(int cartItemId) async {
    final response = await remoteDataSource.removeFromCart(cartItemId);
    return response.fold(
      (failure) => Left(failure),
      (data) => const Right(true),
    );
  }

  @override
  Future<Either<Failure, Data>> updateCartQuantity(
    int cartItemId,
    int quantity,
  ) async {
    final response = await remoteDataSource.updateCartQuantity(
      cartItemId,
      quantity,
    );
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(Data.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, CheckoutData>> checkout() async {
    final response = await remoteDataSource.checkout();
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(CheckoutData.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
