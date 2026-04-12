import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/orders/my_orders/data/models/my_orders_response/my_orders_response.dart';
import 'package:bookia/features/orders/my_orders/domain/usecases/get_orders_usecase.dart';
import 'package:bookia/features/orders/my_orders/presentation/cubit/my_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderCubit extends Cubit<MyOrdersState> {
  final GetOrdersUseCase getOrdersUseCase;

  MyOrderCubit({required this.getOrdersUseCase}) : super(MyOrdersInitial());

  MyOrdersResponse? myOrdersResponse;

  Future<void> getOrders() async {
    emit(MyOrdersLoading());
    final response = await getOrdersUseCase.call(NoParams());

    response.fold((l) => emit(MyOrdersError(message: "failed_to_load_data")), (
      data,
    ) {
      if (data.data != null) {
        myOrdersResponse = data;
        emit(MyOrdersLoaded());
      } else {
        emit(MyOrdersError(message: "failed_to_load_data"));
      }
    });
  }
}
