import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/feature/place_order/presentation/cubit/place_order_state.dart';
import 'package:bookia/feature/place_order/presentation/widgets/gov_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatefulWidget {
  final String total;

  const PlaceOrderScreen({super.key, required this.total});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _governorateController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _governorateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaceOrderCubit()..getGovernorates(),
      child: Scaffold(
        appBar: AppBar(
          title: const CustomBackButton(),
          automaticallyImplyLeading: false,
        ),
        body: MyBodyView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Place Your Order', style: TextStyles.headline),
                  const Gap(10),
                  Text(
                    'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                    style: TextStyles.body.copyWith(color: Colors.grey),
                  ),
                  const Gap(28),
                  CustomTextFormField(
                    controller: _fullNameController,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextFormField(
                    controller: _addressController,
                    hintText: 'Address',
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextFormField(
                    controller: _phoneController,
                    hintText: 'Phone',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller: _governorateController,
                        hintText: 'Governorate',
                        readOnly: true,
                        onTap: () {
                          if (state is GovernoratesSuccessState) {
                            var cubit = context.read<PlaceOrderCubit>();
                            showGovernorateBottomSheet(
                              context,
                              cubit.governorates,
                              (selectedGov) {
                                setState(() {
                                  var selectedGovernorateId = selectedGov.id;
                                  _governorateController.text =
                                      selectedGov.governorateNameEn ?? '';
                                });
                              },
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a governorate';
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.arrow_drop_down),
                      );
                    },
                  ),
                  const Gap(32),
                  Row(
                    children: [
                      Text('Total:', style: TextStyles.subtitle1),
                      const Spacer(),
                      Text('\$ ${widget.total}', style: TextStyles.subtitle1),
                    ],
                  ),
                  const Gap(16),
                  MainButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle order submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order placed successfully!'),
                          ),
                          
                        );
                        pushReplacement(context, route)
                      }
                    },
                    text: 'Submit Order',
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
