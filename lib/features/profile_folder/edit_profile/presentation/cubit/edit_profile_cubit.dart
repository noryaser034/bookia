import 'dart:io';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_params.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/repo/edit_profile_repo.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/cubit/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

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

    var response = await EditProfileRepo.editProfile(params, image: localImage);

    if (response != null) {
      emit(EditProfileUpdated());
    } else {
      emit(EditProfileError());
    }
  }
}
