import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(tr.tr("or")),
            ),
            Expanded(child: Divider()),
          ],
        ),

        const Gap(20),

        /// Google Button
        _socialButton(
          text: tr.tr("google"),
          onTap: () {},
        ),

        const Gap(15),

        /// Apple Button
        _socialButton(
          text: tr.tr("apple"),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _socialButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text, style: TextStyles.body),
      ),
    );
  }
}