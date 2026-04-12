import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/profile_folder/reset_password/data/data_sources/update_password_remote_data_source.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_params.dart';
import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_response/reset_password_response.dart';
import 'package:bookia/features/profile_folder/reset_password/domain/repositories/update_password_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePasswordRepositoryImpl implements UpdatePasswordRepository {
  final UpdatePasswordRemoteDataSource remoteDataSource;

  UpdatePasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ResetPasswordResponse>> updatePassword(
    ResetPasswordParams params,
  ) async {
    final response = await remoteDataSource.updatePassword(params);
    return response.fold((failure) => Left(failure), (data) {
      try {
        return Right(ResetPasswordResponse.fromJson(data));
      } on Exception catch (e) {
        return Left(ParseFailure(message: e.toString()));
      }
    });
  }
}
