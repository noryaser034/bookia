import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/place_order/data/models/governorates_response/governorate_model.dart';
import 'package:bookia/features/place_order/domain/usecases/get_governorates_usecase.dart';
import 'package:bookia/features/place_order/domain/usecases/place_order_usecase.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  final GetGovernoratesUseCase getGovernoratesUseCase;
  final PlaceOrderUseCase placeOrderUseCase;

  PlaceOrderCubit({
    required this.getGovernoratesUseCase,
    required this.placeOrderUseCase,
  }) : super(PlaceOrderInitialState());

  List<GovernorateModel> governorates = [];
  GovernorateModel? selectedGovernorate;

  Future<void> getGovernorates() async {
    if (governorates.isNotEmpty) {
      emit(PlaceOrderGovernoratesSuccessState());
      return;
    }

    emit(PlaceOrderGovernoratesLoadingState());

    final response = await getGovernoratesUseCase.call(NoParams());

    response.fold(
      (l) => emit(
        PlaceOrderGovernoratesErrorState(message: "failed_to_load_data"),
      ),
      (data) {
        if (data.isNotEmpty) {
          governorates = data;
          emit(PlaceOrderGovernoratesSuccessState());
        } else {
          emit(
            PlaceOrderGovernoratesErrorState(message: "failed_to_load_data"),
          );
        }
      },
    );
  }

  void selectGovernorate(GovernorateModel governorate) {
    selectedGovernorate = governorate;
    emit(PlaceOrderGovernoratesSuccessState());
  }

  Future<void> placeOrder({
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    if (selectedGovernorate?.id == null) {
      emit(PlaceOrderErrorState(message: "validation_governorate_empty"));
      return;
    }

    emit(PlaceOrderSubmittingState());

    final response = await placeOrderUseCase.call(
      PlaceOrderParams(
        governorateId: selectedGovernorate!.id!,
        name: name,
        phone: phone,
        address: address,
        email: email,
      ),
    );

    response.fold(
      (l) => emit(PlaceOrderErrorState(message: "failed_to_place_order")),
      (orderId) {
        if (orderId != null) {
          emit(PlaceOrderSuccessState(orderId: orderId));
        } else {
          emit(PlaceOrderErrorState(message: "failed_to_place_order"));
        }
      },
    );
  }
}
