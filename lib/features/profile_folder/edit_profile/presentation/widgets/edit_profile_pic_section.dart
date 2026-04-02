import 'dart:io';

import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:bookia/features/profile_folder/edit_profile/presentation/cubit/edit_profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePicSection extends StatelessWidget {
  const EditProfilePicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        var cubit = context.read<EditProfileCubit>();
        return Stack(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.grayColor,
              radius: 60,
              backgroundImage: cubit.localImage != null
                  ? FileImage(cubit.localImage!) as ImageProvider
                  : (cubit.image.isNotEmpty
                        ? CachedNetworkImageProvider(cubit.image)
                        : null),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      showImagePickerPopup(context);
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showImagePickerPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.translate("choose_profile_picture"),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      pop(sheetContext);
                      pickImage(context, ImageSource.camera);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(context.translate("camera")),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(sheetContext);
                      pickImage(context, ImageSource.gallery);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primaryColor.withValues(
                            alpha: 0.1,
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(context.translate("gallery")),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      if (!context.mounted) return;
      context.read<EditProfileCubit>().setImage(File(image.path));
    }
  }
}
