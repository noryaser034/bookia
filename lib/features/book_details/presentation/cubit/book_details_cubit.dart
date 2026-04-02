import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/wish_list/data/repo/wish_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitialState());

  List<CartItem?> cartItems = [];

  void addToWishList(int productId) async {
    emit(AddToWishListLoadingState());

    var data = await WishListRepo.addToWishList(productId);
    var products = data?.data?.product ?? [];

    if (data != null) {
      SharedPref.cashWishListIds(products);
      emit(AddToWishListSuccessState());
    } else {
      emit(AddToWishListErrorState());
    }
  }

  bool isInWishList(int productId) {
    var wishListIds = SharedPref.getWishListIds();
    return wishListIds.contains(productId);
  }

  void addToCart(int productId) async {
    emit(AddToCartLoadingState());

    final data = await CartRepo.addToCart(productId);

    if (data != null) {
      cartItems = data.cartItems ?? [];
      SharedPref.cashCartListIds(cartItems);
      emit(AddToCartSuccessState());
    } else {
      emit(AddToCartErrorState());
    }
  }

  bool isInCart(int productId) {
    var cartListIds = SharedPref.getCartListIds();
    return cartListIds.contains(productId);
  }
}
