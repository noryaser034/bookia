import 'package:bookia/features/place_order/data/models/governorates_response/governorate_model.dart';
import 'package:bookia/features/place_order/data/repo/place_order_repo.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitialState());

  List<GovernorateModel> governorates = [];
  GovernorateModel? selectedGovernorate;

  Future<void> getGovernorates() async {
    if (governorates.isNotEmpty) {
      emit(PlaceOrderGovernoratesSuccessState());
      return;
    }

    emit(PlaceOrderGovernoratesLoadingState());

    final data = await PlaceOrderRepo.getGovernorates();

    if (data.isNotEmpty) {
      governorates = data;
      emit(PlaceOrderGovernoratesSuccessState());
    } else {
      emit(
        PlaceOrderGovernoratesErrorState(
          message: "failed_to_load_data",
        ),
      );
    }
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

    final orderId = await PlaceOrderRepo.placeOrder(
      governorateId: selectedGovernorate!.id!,
      name: name,
      phone: phone,
      address: address,
      email: email,
    );

    if (orderId != null) {
      emit(PlaceOrderSuccessState(orderId: orderId));
    } else {
      emit(PlaceOrderErrorState(message: "error"));
    }
  }
}
