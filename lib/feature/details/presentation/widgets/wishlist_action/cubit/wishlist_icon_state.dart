class WishlistActionState {}

class WishlistActionsInitial extends WishlistActionState {}

class WishlistActionsState extends WishlistActionState {}

class WishlistActionsSuccessState extends WishlistActionState {
  final String msg;

  WishlistActionsSuccessState({required this.msg});
}

class WishlistActionsErrorState extends WishlistActionState {}
