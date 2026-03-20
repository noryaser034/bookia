import 'package:bookia/feature/profile/data/models/order_model.dart';
import 'package:bookia/feature/profile/data/models/profile_model.dart';
import 'package:bookia/feature/profile/data/repo/profile_repo.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileModel? profile;
  List<OrderModel> orders = [];

  Future<void> getProfile() async {
    emit(GetProfileLoadingState());
    try {
      profile = await ProfileRepo.getProfile();
      emit(GetProfileSuccessState());
    } catch (e) {
      emit(GetProfileErrorState(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(UpdateProfileLoadingState());
    try {
      await ProfileRepo.updateProfile(
        name: name,
        phone: phone,
        address: address,
      );
      await getProfile();
      emit(UpdateProfileSuccessState());
    } catch (e) {
      emit(UpdateProfileErrorState(e.toString()));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    try {
      await ProfileRepo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(ChangePasswordSuccessState());
    } catch (e) {
      emit(ChangePasswordErrorState(e.toString()));
    }
  }

  Future<void> getOrders() async {
    emit(GetOrdersLoadingState());
    try {
      orders = await ProfileRepo.getOrders();
      emit(GetOrdersSuccessState());
    } catch (e) {
      emit(GetOrdersErrorState(e.toString()));
    }
  }
}