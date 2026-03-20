import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:bookia/feature/profile/presentation/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile', style: TextStyles.headline),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await SharedPref.clear();
                  if (!context.mounted) return;
                  context.go(Routes.login);
                },
              ),
            ],
          ),
          body: MyBodyView(
            child: state is GetProfileLoadingState
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: cubit.profile?.image != null
                                ? NetworkImage(cubit.profile!.image!)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.profile?.name ?? '',
                                style: TextStyles.subtitle1,
                              ),
                              Text(
                                cubit.profile?.email ?? '',
                                style: TextStyles.body.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ProfileMenuItem(
                        title: 'My Orders',
                        onTap: () => context.push(Routes.myOrders),
                      ),
                      ProfileMenuItem(
                        title: 'Edit Profile',
                        onTap: () => context.push(Routes.editProfile),
                      ),
                      ProfileMenuItem(
                        title: 'Reset Password',
                        onTap: () => context.push(Routes.changePassword),
                      ),
                      ProfileMenuItem(
                        title: 'FAQ',
                        onTap: () => context.push(Routes.faq),
                      ),
                      ProfileMenuItem(
                        title: 'Contact Us',
                        onTap: () => context.push(Routes.contactUs),
                      ),
                      ProfileMenuItem(title: 'Privacy & Terms', onTap: () {}),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
