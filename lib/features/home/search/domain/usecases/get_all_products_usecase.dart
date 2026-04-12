import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllProductsUseCase implements UseCase<List<Product>, NoParams> {
  final SearchRepository repository;

  GetAllProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getAllProducts();
  }
}
