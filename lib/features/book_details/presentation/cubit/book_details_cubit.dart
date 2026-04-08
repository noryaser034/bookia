import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/wish_list/data/repo/wish_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitialState());

  List<CartItem?> cartItems = [];

  Future<void> addToWishList(int productId) async {
    emit(AddToWishListLoadingState());

    final data = await WishListRepo.addToWishList(productId);

    if (data != null) {
      final products = data.data?.product ?? [];
      SharedPref.cacheWishListIds(products.cast<int>());

      emit(AddToWishListSuccessState());
    } else {
      emit(AddToWishListErrorState(
        'Failed to add to wishlist. Please try again.',
      ));
    }
  }

  bool isInWishList(int productId) {
    final ids = SharedPref.getWishListIds();
    return ids.contains(productId);
  }

  Future<void> addToCart(int productId) async {
    emit(AddToCartLoadingState());

    final data = await CartRepo.addToCart(productId);

    if (data != null) {
      cartItems = data.cartItems ?? [];
      SharedPref.cacheCartListIds(cartItems.cast<int>());

      emit(AddToCartSuccessState());
    } else {
      emit(AddToCartErrorState(
        'Failed to add to cart. Please try again.',
      ));
    }
  }

  bool isInCart(int productId) {
    final ids = SharedPref.getCartListIds();
    return ids.contains(productId);
  }
}