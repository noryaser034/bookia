import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchProductsUseCase implements UseCase<List<Product>, String> {
  final SearchRepository repository;

  SearchProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(String params) {
    return repository.searchProducts(params);
  }
}
