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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: CustomBackButton(),
      ),
      body: _registerBody(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 5, 22, 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr.tr("have_account"), style: TextStyles.caption1),
            const Gap(5),
            GestureDetector(
              onTap: () {
                pushReplacement(context, Routes.login);
              },
              child: Text(
                tr.tr("login"),
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

  Widget _registerBody(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  tr.tr("register"),
                  style: TextStyles.headline,
                ),
                const Gap(32),

                /// Username
                CustomTextFormField(
                  controller: cubit.usernameController,
                  hintText: tr.tr("enter_username"),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr.tr("enter_username");
                    }
                    return null;
                  },
                ),

                const Gap(15),

                /// Email
                CustomTextFormField(
                  controller: cubit.emailController,
                  hintText: tr.tr("enter_email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr.tr("enter_email");
                    } else if (!isEmailValid(value)) {
                      return "Invalid email"; // ممكن تضيفيها في localization
                    }
                    return null;
                  },
                ),

                const Gap(15),

                /// Password
                PasswordTextFormField(
                  controller: cubit.passwordController,
                  hintText: tr.tr("enter_password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr.tr("enter_password");
                    }
                    return null;
                  },
                ),

                const Gap(15),

                /// Confirm Password
                PasswordTextFormField(
                  controller: cubit.passwordConfirmationController,
                  hintText: tr.tr("password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr.tr("password");
                    }
                    return null;
                  },
                ),

                const Gap(30),

                /// Register Button
                MainButton(
                  text: tr.tr("register"),
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.register();
                    }
                  },
                ),

                const Gap(35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}