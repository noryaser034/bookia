import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/app_validators.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/features/cart/data/models/checkout_response/checkout_data.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_screen_btttom_nav_bar.dart';
import 'package:bookia/features/place_order/data/models/governorates_response/governorate_model.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/features/place_order/presentation/cubit/place_order_state.dart';
import 'package:bookia/features/place_order/presentation/widgets/governorates_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key, required this.checkoutData});
  final CheckoutData checkoutData;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;
  late final TextEditingController _governorateController;

  double get totalPrice =>
      double.tryParse(widget.checkoutData.total ?? '0') ?? 0.0;

  @override
  void initState() {
    super.initState();

    final user = widget.checkoutData.user;

    _nameController = TextEditingController(text: user?.userName ?? '');
    _emailController = TextEditingController(text: user?.userEmail ?? '');
    _addressController = TextEditingController(
      text: user?.address?.toString() ?? '',
    );
    _phoneController = TextEditingController(
      text: user?.phone?.toString() ?? '',
    );
    _governorateController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _governorateController.dispose();
    super.dispose();
  }

  Future<void> _showGovernoratesBottomSheet() async {
    final cubit = context.read<PlaceOrderCubit>();

    final result = await showModalBottomSheet<GovernorateModel>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: const GovernoratesBottomSheet(),
        );
      },
    );

    if (!mounted) return;

    if (result != null) {
      cubit.selectGovernorate(result);
      _governorateController.text = result.governorateNameEn ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlaceOrderCubit>();

    return BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
      listener: (context, state) {
        if (state is PlaceOrderSuccessState) {
          pushReplacment(Routes.congrats, context);
        }

        if (state is PlaceOrderErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.translate(state.message))),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: SvgPicture.asset(AppImages.backIconsvg),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate("place_order"),
                      style: TextStyles.w400s30,
                    ),
                    const Gap(10),
                    Text(
                      context.translate("place_order_subtitle"),
                      style: TextStyles.w400s16.copyWith(
                        color: AppColors.grayColor,
                      ),
                    ),
                    const Gap(25),
                    CustomTextFormField(
                      hint: context.translate("fullname"),
                      controller: _nameController,
                      validator: (value) => AppValidators.name(
                        value,
                        emptyMessage: context.translate(
                          "validation_name_empty",
                        ),
                        invalidMessage: context.translate(
                          "validation_name_invalid",
                        ),
                      ),
                    ),
                    const Gap(12),
                    CustomTextFormField(
                      hint: context.translate("email_hint"),
                      controller: _emailController,
                      validator: (value) => AppValidators.email(
                        value,
                        emptyMessage: context.translate(
                          "validation_email_empty",
                        ),
                        invalidMessage: context.translate(
                          "validation_email_invalid",
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Gap(12),
                    CustomTextFormField(
                      hint: context.translate("address"),
                      controller: _addressController,
                      validator: (value) => AppValidators.address(
                        value,
                        emptyMessage: context.translate(
                          "validation_address_empty",
                        ),
                        invalidMessage: context.translate(
                          "validation_address_short",
                        ),
                      ),
                    ),
                    const Gap(12),
                    CustomTextFormField(
                      hint: context.translate("phone"),
                      controller: _phoneController,
                      validator: (value) => AppValidators.phone(
                        value,
                        emptyMessage: context.translate(
                          "validation_phone_empty",
                        ),
                        invalidMessage: context.translate(
                          "validation_phone_invalid",
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const Gap(12),
                    CustomTextFormField(
                      hint: context.translate("choose_governorate"),
                      controller: _governorateController,
                      readOnly: true,
                      onTap: _showGovernoratesBottomSheet,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.translate(
                            "validation_governorate_empty",
                          );
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: CartScreenBtttomNavBar(
              text: context.translate("place_order"),
              totalPrice: totalPrice,
              isLoading: state is PlaceOrderSubmittingState,
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                cubit.placeOrder(
                  name: _nameController.text.trim(),
                  email: _emailController.text.trim(),
                  address: _addressController.text.trim(),
                  phone: _phoneController.text.trim(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
