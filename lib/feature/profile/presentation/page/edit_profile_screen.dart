import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().profile;
    _nameController.text = profile?.name ?? '';
    _phoneController.text = profile?.phone ?? '';
    _addressController.text = profile?.address ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          showMyDialog(
            context,
            'Profile updated successfully',
            type: DialogType.success,
          );
          Navigator.pop(context);
        }
        if (state is UpdateProfileErrorState) {
          showMyDialog(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const CustomBackButton(),
          centerTitle: false,
          automaticallyImplyLeading: false,
        ),
        body: MyBodyView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Edit Profile', style: TextStyles.headline),
                  const Gap(32),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            context.read<ProfileCubit>().profile?.image != null
                            ? NetworkImage(
                                context.read<ProfileCubit>().profile!.image!,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xFFC4A84F),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(32),
                  CustomTextFormField(
                    controller: _nameController,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextFormField(
                    controller: _phoneController,
                    hintText: 'Phone',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextFormField(
                    controller: _addressController,
                    hintText: 'Address',
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const Gap(32),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return MainButton(
                        onPressed: state is UpdateProfileLoadingState
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ProfileCubit>().updateProfile(
                                    name: _nameController.text,
                                    phone: _phoneController.text,
                                    address: _addressController.text,
                                  );
                                }
                              },
                        text: state is UpdateProfileLoadingState
                            ? 'Loading...'
                            : 'Update Profile',
                      );
                    },
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
