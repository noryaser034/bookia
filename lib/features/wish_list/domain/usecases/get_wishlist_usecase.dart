import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/wish_list/data/models/wish_list_response/wish_list_response.dart';
import 'package:bookia/features/wish_list/domain/repositories/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class GetWishlistUseCase implements UseCase<WishListResponse, NoParams> {
  final WishlistRepository repository;

  GetWishlistUseCase(this.repository);

  @override
  Future<Either<Failure, WishListResponse>> call(NoParams params) {
    return repository.getWishlist();
  }
}
