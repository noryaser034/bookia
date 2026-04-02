import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/app_validators.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/features/profile_folder/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:bookia/features/profile_folder/reset_password/presentation/cubit/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ResetPasswordCubit>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: SvgPicture.asset(AppImages.backIconsvg),
        ),
      ),
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            pop(context); // close loading dialog
            pop(context); // pop back
          } else if (state is ResetPasswordError) {
            pop(context); // close loading dialog
            showMyDialog(context, context.translate(state.message));
          } else if (state is ResetPasswordLoading) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: cubit.formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.translate("new_password"),
                      style: TextStyles.w400s30),
                  const Gap(73),
                  PasswordTextFormField(
                    hint: context.translate("current_password"),
                    passwordController: cubit.currentPasswordController,
                    validator: AppValidators.password(
                      emptyMessage:
                          context.translate("validation_current_password_empty"),
                      invalidMessage:
                          context.translate("validation_password_invalid"),
                    ),
                  ),
                  const Gap(26),
                  PasswordTextFormField(
                    hint: context.translate("new_password"),
                    passwordController: cubit.newPasswordController,
                    validator: AppValidators.password(
                      emptyMessage:
                          context.translate("validation_password_empty"),
                      invalidMessage:
                          context.translate("validation_password_invalid"),
                    ),
                  ),
                  const Gap(26),
                  PasswordTextFormField(
                    hint: context.translate("confirm_password"),
                    passwordController: cubit.confirmPasswordController,
                    validator: AppValidators.confirmPassword(
                      passwordProvider: () => cubit.newPasswordController.text,
                      emptyMessage: context
                          .translate("validation_confirm_password_empty"),
                      invalidMessage: context.translate(
                          "validation_confirm_password_invalid"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MainButton(
          text: context.translate("update_password"),
          onPressed: () {
            if (cubit.formKey.currentState!.validate()) {
              cubit.updatePassword();
            }
          },
        ),
      ),
    );
  }
}
