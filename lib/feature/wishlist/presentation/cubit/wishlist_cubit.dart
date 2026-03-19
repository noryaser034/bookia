import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/home/data/models/best_seller_books_response/product.dart';
import 'package:bookia/feature/wishlist/data/repository/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  List<Product> products = [];

  Future<void> getWishlist() async {
    emit(WishlistLoadingState());
    var data = await WishlistRepo.getWishlist();
    if (data != null) {
      products = data.data?.products ?? [];
      SharedPref.cacheWishlistIds(products);
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(WishlistLoadingState());
    var data = await WishlistRepo.removeFromWishlist(productId);
    if (data != null) {
      products = data.data?.products ?? [];
      SharedPref.cacheWishlistIds(products);
      emit(WishlistSuccessState());
    } else {
      emit(WishlistErrorState());
    }
  }
}
