import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepository {
  Future<Either<Failure, Data>> getCartItems();
  Future<Either<Failure, Data>> addToCart(int productId);
  Future<Either<Failure, bool>> removeFromCart(int cartItemId);
  Future<Either<Failure, Data>> updateCartQuantity(
    int cartItemId,
    int quantity,
  );
  Future<Either<Failure, CheckoutData>> checkout();
}
