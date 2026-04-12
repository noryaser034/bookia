import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Product>>> searchProducts(String name);
}
