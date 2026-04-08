abstract class BookDetailsState {}

class BookDetailsInitialState extends BookDetailsState {}

// Wishlist states
class AddToWishListLoadingState extends BookDetailsState {}

class AddToWishListSuccessState extends BookDetailsState {}

class AddToWishListErrorState extends BookDetailsState {
  final String message;
  AddToWishListErrorState(this.message);
}

// Cart states
class AddToCartLoadingState extends BookDetailsState {}

class AddToCartSuccessState extends BookDetailsState {}

class AddToCartErrorState extends BookDetailsState {
  final String message;
  AddToCartErrorState(this.message);
}
