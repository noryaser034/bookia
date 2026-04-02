import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/profile_folder/profile/presentation/widgets/profile_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileData = SharedPref.getUserInfo();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate("profile"), style: TextStyles.w400s24),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              showLoadingDialog(context);

              final success = await AuthRepo.logout();

              if (!context.mounted) return;

              pop(context);

              if (success) {
                pushAndClearStack(Routes.login, context);
              } else {
                showMyDialog(context, context.translate("failed_to_logout"));
              }
            },
            icon: SvgPicture.asset(AppImages.logoutIconSvg),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      (profileData?.image != null &&
                           profileData!.image!.isNotEmpty)
                      ? CachedNetworkImageProvider(profileData.image!)
                      : null,
                ),
                const Gap(13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profileData?.name ?? "", style: TextStyles.w400s20),
                    Text(
                      profileData?.email ?? "",
                      style: TextStyles.w400s14.copyWith(
                        color: AppColors.grayColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(35),
            ProfileTile(
              title: context.translate("my_orders"),
              onTap: () => pushTo(Routes.myOrders, context),
            ),
            const Gap(10),
            ProfileTile(
              title: context.translate("edit_profile"),
              onTap: () async {
                await pushTo(Routes.editProfile, context);

                if (!context.mounted) return;

                setState(() {});
              },
            ),
            const Gap(10),
            ProfileTile(
              title: context.translate("reset_password"),
              onTap: () => pushTo(Routes.resetPassword, context),
            ),
            const Gap(10),
            ProfileTile(title: context.translate("faq")),
            const Gap(10),
            ProfileTile(title: context.translate("contact_us")),
            const Gap(10),
            ProfileTile(title: context.translate("privacy_terms")),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
