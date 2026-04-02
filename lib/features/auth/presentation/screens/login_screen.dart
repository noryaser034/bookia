import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/core/functions/app_validators.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:bookia/features/auth/presentation/widgets/social_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            return Form(
              key: cubit.formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Text(
                        context.translate("welcome_back"),
                        style: TextStyles.w400s30,
                      ),
                      const Gap(32),
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
                      const Gap(15),
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
                      const Gap(15),
                      TextButton(
                        onPressed: () {
                          pushTo(Routes.forgetPassword, context);
                        },
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            context.translate("forgot_password"),
                            style: TextStyles.w400s14.copyWith(
                              color: AppColors.darkGray,
                            ),
                          ),
                        ),
                      ),
                      const Gap(30),
                      MainButton(
                        text: context.translate("login"),
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.login();
                          }
                        },
                      ),
                      const Gap(30),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: Text(
                              context.translate("or"),
                              style: TextStyles.w400s14.copyWith(
                                color: AppColors.darkGray,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const Gap(30),
                      SocialAuthButton(
                        iconPath: AppImages.googleIconSvg,
                        text: context.translate("google_auth"),
                        onTap: () {},
                      ),
                      const Gap(15),
                      SocialAuthButton(
                        iconPath: AppImages.appleIconSvg,
                        text: context.translate("apple_auth"),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: AuthFooter(
          text: context.translate("no_account"),
          textButton: context.translate("register_now"),
          onPressed: () => pushTo(Routes.register, context),
        ),
      ),
    );
  }
}

