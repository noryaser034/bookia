import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/core/functions/app_validators.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: SvgPicture.asset(AppImages.backIconsvg),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              pushAndClearStack(Routes.mainApp, context);
            } else if (state is AuthErrorState) {
              pop(context);
              showMyDialog(context, context.translate(state.message));
            } else if (state is AuthLoadingState) {
              showLoadingDialog(context);
            }
          },
          builder: (context, state) {
            var cubit = context.read<AuthCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: cubit.formKey,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  child: Column(
                    children: [
                      Text(
                        context.translate("hello"),
                        style: TextStyles.w400s30,
                      ),
                      const Gap(32),
                      CustomTextFormField(
                        hint: context.translate("username_hint"),
                        validator: (value) => AppValidators.name(
                          value,
                          emptyMessage: context.translate("validation_name_empty"),
                          invalidMessage:
                              context.translate("validation_name_invalid"),
                        ),
                        controller: cubit.userNameController,
                      ),
                      const Gap(11),
                      CustomTextFormField(
                        hint: context.translate("email_hint"),
                        validator: (value) => AppValidators.email(
                          value,
                          emptyMessage: context.translate("validation_email_empty"),
                          invalidMessage:
                              context.translate("validation_email_invalid"),
                        ),
                        controller: cubit.emailController,
                      ),
                      const Gap(11),
                      PasswordTextFormField(
                        hint: context.translate("password_hint"),
                        validator: AppValidators.password(
                          emptyMessage:
                              context.translate("validation_password_empty"),
                          invalidMessage:
                              context.translate("validation_password_invalid"),
                        ),
                        passwordController: cubit.passwordController,
                      ),
                      const Gap(11),
                      PasswordTextFormField(
                        hint: context.translate("confirm_password"),
                        validator: AppValidators.confirmPassword(
                          passwordProvider: () => cubit.passwordController.text,
                          emptyMessage: context
                              .translate("validation_confirm_password_empty"),
                          invalidMessage: context.translate(
                              "validation_confirm_password_invalid"),
                        ),
                        passwordController: cubit.confirmController,
                      ),
                      const Gap(30),
                      MainButton(
                        text: context.translate("register"),
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.register();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: AuthFooter(
          text: context.translate("already_have_account"),
          textButton: context.translate("login_now"),
          onPressed: () => pop(context),
        ),
      ),
    );
  }
}
