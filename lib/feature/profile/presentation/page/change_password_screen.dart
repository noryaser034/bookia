import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          showMyDialog(context, 'Password changed successfully',
              type: DialogType.success);
          Navigator.pop(context);
        }
        if (state is ChangePasswordErrorState) {
          showMyDialog(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const CustomBackButton(),
          automaticallyImplyLeading: false,
        ),
        body: MyBodyView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(16),
                  Text('New Password', style: TextStyles.headline),
                  const Gap(32),
                  PasswordTextFormField(
                    controller: _currentPasswordController,
                    hintText: 'Current Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter current password';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  PasswordTextFormField(
                    controller: _newPasswordController,
                    hintText: 'New Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter new password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  PasswordTextFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const Gap(32),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return MainButton(
                        onPressed: state is ChangePasswordLoadingState
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<ProfileCubit>()
                                      .changePassword(
                                        currentPassword:
                                            _currentPasswordController.text,
                                        newPassword:
                                            _newPasswordController.text,
                                        confirmPassword:
                                            _confirmPasswordController.text,
                                      );
                                }
                              },
                        text: state is ChangePasswordLoadingState
                            ? 'Loading...'
                            : 'Update Password',
                      );
                    },
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}