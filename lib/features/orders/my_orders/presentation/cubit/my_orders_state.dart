abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersLoaded extends MyOrdersState {}

class MyOrdersError extends MyOrdersState {
  final String message;
  MyOrdersError({required this.message});
}
