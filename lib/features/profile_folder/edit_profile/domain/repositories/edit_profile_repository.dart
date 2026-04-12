import 'dart:io';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_params.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:dartz/dartz.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, EditProfileResponse>> editProfile(
    EditProfileParams params, {
    File? image,
  });
}
