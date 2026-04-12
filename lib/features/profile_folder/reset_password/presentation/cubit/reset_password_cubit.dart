import 'package:bookia/features/profile_folder/reset_password/data/models/reset_password_params.dart';
import 'package:bookia/features/profile_folder/reset_password/domain/usecases/update_password_usecase.dart';
import 'package:bookia/features/profile_folder/reset_password/presentation/cubit/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final UpdatePasswordUseCase updatePasswordUseCase;

  ResetPasswordCubit({required this.updatePasswordUseCase})
    : super(ResetPasswordInitial());

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ResetPasswordParams params = ResetPasswordParams();

  Future<void> updatePassword() async {
    emit(ResetPasswordLoading());

    params.currentPassword = currentPasswordController.text;
    params.newPassword = newPasswordController.text;
    params.newPasswordConfirmation = confirmPasswordController.text;

    var response = await updatePasswordUseCase.call(params);

    response.fold(
      (l) => emit(
        ResetPasswordError(
          message: "Failed to update password. Please try again.",
        ),
      ),
      (data) {
        if (data.message != null) {
          emit(ResetPasswordSuccess(message: data.message!));
        } else {
          emit(
            ResetPasswordError(
              message: "Failed to update password. Please try again.",
            ),
          );
        }
      },
    );
  }
}
