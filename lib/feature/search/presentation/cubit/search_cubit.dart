import 'package:bookia/feature/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/feature/search/presentation/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.allProducts) : super(SearchInitial());

  final List<Product> allProducts;
  List<Product> searchResults = [];

  void search(String query) {
    if (query.isEmpty) {
      searchResults = [];
      emit(SearchInitial());
      return;
    }
    emit(SearchLoadingState());
    searchResults = allProducts
        .where((product) =>
            product.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();
    if (searchResults.isEmpty) {
      emit(SearchEmptyState());
    } else {
      emit(SearchSuccessState());
    }
  }
}