abstract class BookDetailsState {}

class BookDetailsInitialState extends BookDetailsState {}

// Wishlist states
class AddToWishListLoadingState extends BookDetailsState {}

class AddToWishListSuccessState extends BookDetailsState {}

class AddToWishListErrorState extends BookDetailsState {}

// Cart states
class AddToCartLoadingState extends BookDetailsState {}

class AddToCartSuccessState extends BookDetailsState {}

class AddToCartErrorState extends BookDetailsState {}
