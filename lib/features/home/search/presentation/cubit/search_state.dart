import 'package:bookia/features/home/home/data/models/product_model/product.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Product> products;

  SearchSuccess({required this.products});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
