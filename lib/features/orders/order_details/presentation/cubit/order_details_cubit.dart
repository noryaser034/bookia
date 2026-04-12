import 'package:bookia/features/orders/order_details/data/models/order_details_response/order_details_response.dart';
import 'package:bookia/features/orders/order_details/domain/usecases/get_order_details_usecase.dart';
import 'package:bookia/features/orders/order_details/presentation/cubit/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final GetOrderDetailsUseCase getOrderDetailsUseCase;

  OrderDetailsCubit({required this.getOrderDetailsUseCase})
    : super(OrderDetailsInitial());

  OrderDetailsResponse? orderDetailsResponse;

  Future<void> getOrderDetails(int orderId) async {
    emit(OrderDetailsLoading());

    final response = await getOrderDetailsUseCase.call(orderId);

    response.fold(
      (l) => emit(OrderDetailsError(message: "failed_to_load_data")),
      (data) {
        if (data.data != null) {
          orderDetailsResponse = data;
          emit(OrderDetailsLoaded());
        } else {
          emit(OrderDetailsError(message: "failed_to_load_data"));
        }
      },
    );
  }
}
