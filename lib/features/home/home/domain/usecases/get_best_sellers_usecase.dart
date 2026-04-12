import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetBestSellersUseCase implements UseCase<List<Product>, NoParams> {
  final HomeRepository repository;

  GetBestSellersUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getBestSellerProducts();
  }
}
