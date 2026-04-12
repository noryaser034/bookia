import 'dart:io';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/usecase/usecase.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_params.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:bookia/features/profile_folder/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:dartz/dartz.dart';

class EditProfileUseCaseParams {
  final EditProfileParams params;
  final File? image;

  EditProfileUseCaseParams({required this.params, this.image});
}

class EditProfileUseCase
    implements UseCase<EditProfileResponse, EditProfileUseCaseParams> {
  final EditProfileRepository repository;

  EditProfileUseCase(this.repository);

  @override
  Future<Either<Failure, EditProfileResponse>> call(
    EditProfileUseCaseParams params,
  ) {
    return repository.editProfile(params.params, image: params.image);
  }
}
