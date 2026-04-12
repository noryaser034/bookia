import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:bookia/features/wish_list/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final AddToWishlistUseCase addToWishlistUseCase;
  final AddToCartUseCase addToCartUseCase;

  BookDetailsCubit({
    required this.addToWishlistUseCase,
    required this.addToCartUseCase,
  }) : super(BookDetailsInitialState());

  List<CartItem?> cartItems = [];

  void addToWishList(int productId) async {
    emit(AddToWishListLoadingState());

    var response = await addToWishlistUseCase.call(productId);

    response.fold((l) => emit(AddToWishListErrorState()), (data) {
      var products = data.data?.product ?? [];
      SharedPref.cashWishListIds(products);
      emit(AddToWishListSuccessState());
    });
  }

  bool isInWishList(int productId) {
    var wishListIds = SharedPref.getWishListIds();
    return wishListIds.contains(productId);
  }

  void addToCart(int productId) async {
    emit(AddToCartLoadingState());

    final response = await addToCartUseCase.call(productId);

    response.fold((l) => emit(AddToCartErrorState()), (data) {
      cartItems = data.cartItems ?? [];
      SharedPref.cashCartListIds(cartItems);
      emit(AddToCartSuccessState());
    });
  }

  bool isInCart(int productId) {
    var cartListIds = SharedPref.getCartListIds();
    return cartListIds.contains(productId);
  }
}
