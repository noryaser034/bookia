import 'package:bookia/features/orders/order_details/data/models/order_details_response/order_details_response.dart';
import 'package:bookia/features/orders/order_details/data/repo/order_details_repo.dart';
import 'package:bookia/features/orders/order_details/presentation/cubit/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());

  OrderDetailsResponse? orderDetailsResponse;

  Future<void> getOrderDetails(int orderId) async {
    emit(OrderDetailsLoading());

    try {
      final response = await OrderDetailsRepo.getOrderDetails(orderId);

      if (response != null && response.data != null) {
        orderDetailsResponse = response;
        emit(OrderDetailsLoaded());
      } else {
        emit(
          OrderDetailsError(
            message: response?.message ?? "failed_to_load_data",
          ),
        );
      }
    } catch (e) {
      emit(OrderDetailsError(message: "error"));
    }
  }
}
