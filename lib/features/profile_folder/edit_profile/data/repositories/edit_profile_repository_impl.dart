import 'dart:io';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/data_sources/edit_profile_remote_data_source.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_params.dart';
import 'package:bookia/features/profile_folder/edit_profile/data/models/edit_profile_response/edit_profile_response.dart';
import 'package:bookia/features/profile_folder/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:dartz/dartz.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSource remoteDataSource;

  EditProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, EditProfileResponse>> editProfile(
    EditProfileParams params, {
    File? image,
  }) async {
    final response = await remoteDataSource.editProfile(params, image: image);
    return response.fold((failure) => Left(failure), (data) {
      try {
        var parsedData = EditProfileResponse.fromJson(data);

        // Update cached user info
        final updatedUser = User(
          id: SharedPref.getUserInfo()?.id,
          name: parsedData.data?.name,
          email: SharedPref.getUserInfo()?.email,
          address: parsedData.data?.address,
          phone: parsedData.data?.phone,
          image: parsedData.data?.image,
          emailVerified: SharedPref.getUserInfo()?.emailVerified,
        );
        SharedPref.setUserInfo(updatedUser);

        return Right(parsedData);
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
