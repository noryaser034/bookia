import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/wish_list/data/models/wish_list_response/wish_list_response.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepository {
  Future<Either<Failure, WishListResponse>> getWishlist();
  Future<Either<Failure, WishListResponse>> addToWishlist(int productId);
  Future<Either<Failure, WishListResponse>> removeFromWishlist(int productId);
}
