import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/app_validators.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/cubit/edit_profile_state.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/widgets/edit_profile_pic_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EditProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate("edit_profile"), style: TextStyles.w400s24),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: SvgPicture.asset(AppImages.backIconsvg),
          ),
        ),
        leadingWidth: 70,
      ),
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileUpdated) {
            pop(context); // close loading dialog
            pop(context); // pop back to profile screen
          } else if (state is EditProfileError) {
            pop(context); // close loading dialog
            showMyDialog(context, context.translate(state.message));
          } else if (state is EditProfileLoading) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: cubit.formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const EditProfilePicSection(),
                    const Gap(54),
                    CustomTextFormField(
                      hint: context.translate("fullname"),
                      controller: cubit.nameController,
                      validator: (value) => AppValidators.name(
                        value,
                        emptyMessage: context.translate("validation_name_empty"),
                        invalidMessage:
                            context.translate("validation_name_invalid"),
                      ),
                    ),
                    const Gap(20),
                    CustomTextFormField(
                      hint: context.translate("phone"),
                      controller: cubit.phoneController,
                      validator: (value) => AppValidators.phone(
                        value,
                        emptyMessage: context.translate("validation_phone_empty"),
                        invalidMessage:
                            context.translate("validation_phone_invalid"),
                      ),
                    ),
                    const Gap(20),
                    CustomTextFormField(
                      hint: context.translate("address"),
                      controller: cubit.addressController,
                      validator: (value) => AppValidators.address(
                        value,
                        emptyMessage:
                            context.translate("validation_address_empty"),
                        invalidMessage:
                            context.translate("validation_address_short"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MainButton(
          text: context.translate("update_profile"),
          onPressed: () {
            if (cubit.formKey.currentState!.validate()) {
              cubit.editProfile();
            }
          },
        ),
      ),
    );
  }
}
