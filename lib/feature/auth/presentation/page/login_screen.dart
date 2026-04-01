import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/functions/validations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/feature/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: _loginBody(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr.tr("no_account"), style: TextStyles.caption1),
            const Gap(5),
            GestureDetector(
              onTap: () => pushReplacement(context, Routes.register),
              child: Text(
                tr.tr("register"),
                style: TextStyles.caption1.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginBody(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    var tr = AppLocalizations.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushToBase(context, Routes.main);
        } else if (state is AuthErrorState) {
          pop(context);
          showMyDialog(context, state.message);
        } else if (state is AuthLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: MyBodyView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              Text(tr.tr("welcome_back"), style: TextStyles.headline),
              const Gap(32),
              CustomTextFormField(
                controller: cubit.emailController,
                hintText: tr.tr("enter_email"),
                validator: (v) => v!.isEmpty ? tr.tr("enter_email") : null,
              ),
              const Gap(15),
              PasswordTextFormField(
                controller: cubit.passwordController,
                hintText: tr.tr("enter_password"),
              ),
              const Gap(15),
              Align(
                alignment: Alignment.centerRight,
                child: Text(tr.tr("forgot_password")),
              ),
              const Gap(30),
              MainButton(
                text: tr.tr("login"),
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.login();
                  }
                },
              ),
              const Gap(35),
              SocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}