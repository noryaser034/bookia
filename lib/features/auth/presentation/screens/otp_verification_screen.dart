import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/widgets/auth_footer.dart';
import 'package:bookia/features/auth/presentation/widgets/pin_code_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: SvgPicture.asset(AppImages.backIconsvg),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.translate("otp_verification"),
              style: TextStyles.w400s30,
            ),
            const Gap(10),
            Text(
              context.translate("otp_verification_subtitle"),
              style: TextStyles.w400s16.copyWith(color: AppColors.grayColor),
            ),
            const Gap(35),
            PinCodeSection(controller: cubit.otpController),
            const Gap(35),
            MainButton(
              text: context.translate("verify"),
              onPressed: () {
                if (cubit.otpController.text.trim().length == 6) {
                  pushTo(Routes.createNewPassword, context, extra: cubit);
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthFooter(
        text: context.translate("no_account"),
        textButton: context.translate("resend"),
      ),
    );
  }
}
