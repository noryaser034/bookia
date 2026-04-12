import 'dart:async';
import 'package:bookia/core/localization/app_localizations.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/home/home/presentation/widgets/book_card.dart';
import 'package:bookia/features/home/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/home/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isLoadingDialogVisible = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SearchCubit>().getAllProducts();
    });
  }

  void _showLoader() {
    if (!_isLoadingDialogVisible) {
      _isLoadingDialogVisible = true;
      showLoadingDialog(context);
    }
  }

  void _hideLoader() {
    if (_isLoadingDialogVisible) {
      final navigator = Navigator.of(context, rootNavigator: true);
      if (navigator.canPop()) {
        navigator.pop();
      }
      _isLoadingDialogVisible = false;
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      context.read<SearchCubit>().searchProducts(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _hideLoader();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: SvgPicture.asset(AppImages.backIconsvg),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchLoading) {
              _showLoader();
            } else if (state is SearchSuccess) {
              _hideLoader();
            } else if (state is SearchError) {
              _hideLoader();
              showMyDialog(context, context.translate(state.message));
            } else if (state is SearchInitial) {
              _hideLoader();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                CustomTextFormField(
                  hint: context.translate("search_for_books"),
                  icon: const Icon(Icons.search),
                  onChanged: _onSearchChanged,
                ),
                const Gap(20),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is SearchSuccess) {
                        if (state.products.isEmpty) {
                          return Center(
                            child: Text(context.translate("no_products_found")),
                          );
                        }

                        return GridView.builder(
                          itemCount: state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 11,
                                mainAxisSpacing: 11,
                                childAspectRatio: 0.5,
                              ),
                          itemBuilder: (context, index) {
                            return BookCard(product: state.products[index]);
                          },
                        );
                      }

                      if (state is SearchError) {
                        return const SizedBox.shrink();
                      }

                      return Center(child: Text(context.translate("loading")));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
