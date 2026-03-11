import 'package:bookia/core/widgets/shimmer/grid_shimmer.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:bookia/feature/home/presentation/widget/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerBooks extends StatelessWidget {
  const BestSellerBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          var books = context.read<HomeCubit>().products;

          return GridView.builder(
            itemCount: books.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 11,
              crossAxisSpacing: 11,
              childAspectRatio: 0.52,
            ),
            itemBuilder: (context, index) {
              return BookCard(product: books[index]);
            },
          );
        } else if (state is HomeErrorState) {
          return const Center(child: Text("Error loading books"));
        } else {
          // حالة التحميل (Loading)
          return const GridShimmer(
            crossAxisCount: 2,
            mainAxisSpacing: 11,
            crossAxisSpacing: 11,
            childAspectRatio: 0.52,
          );
        }
      },
    );
  }
}
