import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/wish_list/data/data_sources/wishlist_remote_data_source.dart';
import 'package:bookia/features/wish_list/data/models/wish_list_response/wish_list_response.dart';
import 'package:bookia/features/wish_list/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WishListResponse>> getWishlist() async {
    final response = await remoteDataSource.getWishlist();
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(WishListResponse.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, WishListResponse>> addToWishlist(int productId) async {
    final response = await remoteDataSource.addToWishlist(productId);
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(WishListResponse.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, WishListResponse>> removeFromWishlist(
    int productId,
  ) async {
    final response = await remoteDataSource.removeFromWishlist(productId);
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(WishListResponse.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
