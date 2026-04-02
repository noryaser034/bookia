import 'package:bookia/features/orders/my_orders/data/models/my_orders_response/my_orders_response.dart';
import 'package:bookia/features/orders/my_orders/data/repo/my_orders_repo.dart';
import 'package:bookia/features/orders/my_orders/presentation/cubit/my_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderCubit extends Cubit<MyOrdersState> {
  MyOrderCubit() : super(MyOrdersInitial());

  MyOrdersResponse? myOrdersResponse;

  Future<void> getOrders() async {
    emit(MyOrdersLoading());
    try {
      final response = await MyOrdersRepo.getOrders();
      if (response != null && response.data != null) {
        myOrdersResponse = response;
        emit(MyOrdersLoaded());
      } else {
        emit(
          MyOrdersError(
            message: response?.message ?? "failed_to_load_data",
          ),
        );
      }
    } catch (e) {
      emit(MyOrdersError(message: "error"));
    }
  }
}
