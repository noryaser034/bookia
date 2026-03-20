import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/faq/presentation/cubit/faq_cubit.dart';
import 'package:bookia/feature/faq/presentation/cubit/faq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FaqCubit>().getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomBackButton(),
        automaticallyImplyLeading: false,
      ),
      body: MyBodyView(
        child: BlocBuilder<FaqCubit, FaqState>(
          builder: (context, state) {
            if (state is FaqLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FaqErrorState) {
              return Center(child: Text(state.message));
            }
            if (state is FaqSuccessState) {
              final faqs = context.read<FaqCubit>().faqs;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FAQ', style: TextStyles.headline),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: faqs.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final faq = faqs[index];
                        return ExpansionTile(
                          title: Text(faq.question, style: TextStyles.body),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text(
                                faq.answer,
                                style: TextStyles.body.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
