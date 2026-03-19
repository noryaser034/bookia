class CartActionState {}

class CartActionsInitial extends CartActionState {}

class CartActionsLoadingState extends CartActionState {}

class CartActionsSuccessState extends CartActionState {
  final String msg;

  CartActionsSuccessState({required this.msg});
}

class CartActionsErrorState extends CartActionState {}
