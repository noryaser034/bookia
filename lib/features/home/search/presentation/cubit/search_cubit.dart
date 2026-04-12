import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/home/home/data/models/product_model/product.dart';
import 'package:bookia/features/home/search/domain/usecases/get_all_products_usecase.dart';
import 'package:bookia/features/home/search/domain/usecases/search_products_usecase.dart';
import 'package:bookia/features/home/search/presentation/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  SearchCubit({
    required this.getAllProductsUseCase,
    required this.searchProductsUseCase,
  }) : super(SearchInitial());

  List<Product> products = [];

  Future<void> getAllProducts() async {
    emit(SearchLoading());

    final response = await getAllProductsUseCase.call(NoParams());
    response.fold((l) => products = [], (r) => products = r);
    emit(SearchSuccess(products: products));
  }

  Future<void> searchProducts(String name) async {
    if (name.trim().isEmpty) {
      await getAllProducts();
      return;
    }

    emit(SearchLoading());

    final response = await searchProductsUseCase.call(name.trim());
    response.fold((l) => products = [], (r) => products = r);
    emit(SearchSuccess(products: products));
  }
}
