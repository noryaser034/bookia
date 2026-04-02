class PlaceOrderState {}

class PlaceOrderInitialState extends PlaceOrderState {}

class PlaceOrderGovernoratesLoadingState extends PlaceOrderState {}

class PlaceOrderGovernoratesSuccessState extends PlaceOrderState {}

class PlaceOrderGovernoratesErrorState extends PlaceOrderState {
  final String message;

  PlaceOrderGovernoratesErrorState({required this.message});
}

class PlaceOrderSubmittingState extends PlaceOrderState {}

class PlaceOrderSuccessState extends PlaceOrderState {
  final int orderId;

  PlaceOrderSuccessState({required this.orderId});
}

class PlaceOrderErrorState extends PlaceOrderState {
  final String message;

  PlaceOrderErrorState({required this.message});
}
