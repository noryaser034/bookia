import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/core/functions/app_validators.dart';
import 'package:bookia/core/di/injection_container.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
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
            if (state is AuthLoadingState) {
              showLoadingDialog(context);
            } else if (state is AuthSuccessState) {
              pop(context);
              pushTo(
                Routes.otpScreen,
                context,
                extra: context.read<AuthCubit>(),
              );
            } else if (state is AuthErrorState) {
              pop(context);
              showMyDialog(context, context.translate(state.message));
            }
          },
          builder: (context, state) {
            var cubit = context.read<AuthCubit>();
            return Padding(
              padding: const EdgeInsets.all(22),
              child: Form(
                key: cubit.formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate("forgot_password_title"),
                      style: TextStyles.w400s30,
                    ),
                    const Gap(10),
                    Text(
                      context.translate("forgot_password_subtitle"),
                      style: TextStyles.w400s16.copyWith(
                        color: AppColors.grayColor,
                      ),
                    ),
                    const Gap(30),
                    CustomTextFormField(
                      hint: context.translate("email_hint"),
                      validator: (value) => AppValidators.email(
                        value,
                        emptyMessage: context.translate(
                          "validation_email_empty",
                        ),
                        invalidMessage: context.translate(
                          "validation_email_invalid",
                        ),
                      ),
                      controller: cubit.emailController,
                    ),
                    const Gap(40),
                    MainButton(
                      text: context.translate("send_code"),
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.forgetPassword();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: AuthFooter(
          text: context.translate("no_account"),
          textButton: context.translate("register_now"),
          onPressed: () => pop(context),
        ),
      ),
    );
  }
}
