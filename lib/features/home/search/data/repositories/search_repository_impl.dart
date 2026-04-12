import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/search/data/data_sources/search_remote_data_source.dart';
import 'package:bookia/features/home/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    final response = await remoteDataSource.getAllProducts();
    return response.fold((failure) => Left(failure), (data) {
      try {
        final List productsJson = data["products"] ?? [];
        final products = productsJson.map((e) => Product.fromJson(e)).toList();
        return Right(products);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String name) async {
    final response = await remoteDataSource.searchProducts(name: name);
    return response.fold((failure) => Left(failure), (data) {
      try {
        final List productsJson = data["products"] ?? [];
        final products = productsJson.map((e) => Product.fromJson(e)).toList();
        return Right(products);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
