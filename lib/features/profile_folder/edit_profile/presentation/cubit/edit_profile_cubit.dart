import 'dart:io';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_params.dart';
import 'package:bookia/features/profile_folder/edit_profile/domain/usecases/edit_profile_usecase.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/cubit/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase editProfileUseCase;

  EditProfileCubit({required this.editProfileUseCase})
    : super(EditProfileInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String image = "";
  File? localImage;
  final EditProfileParams params = EditProfileParams();

  void setImage(File imageP) {
    localImage = imageP;
    emit(EditProfileImagePicked());
  }

  void loadInitialData() {
    var profileData = SharedPref.getUserInfo();
    nameController.text = profileData?.name ?? "";
    phoneController.text = profileData?.phone ?? "";
    addressController.text = profileData?.address ?? "";
    image = profileData?.image ?? "";
    params.name = nameController.text;
    params.phone = phoneController.text;
    params.address = addressController.text;
    emit(EditProfileSuccess());
  }

  Future<void> editProfile() async {
    emit(EditProfileLoading());

    params.name = nameController.text;
    params.phone = phoneController.text;
    params.address = addressController.text;

    var response = await editProfileUseCase.call(
      EditProfileUseCaseParams(params: params, image: localImage),
    );

    response.fold(
      (l) => emit(EditProfileError()),
      (data) => emit(EditProfileUpdated()),
    );
  }
}
