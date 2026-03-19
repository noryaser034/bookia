import 'package:bookia/core/widgets/shimmer/grid_shimmer.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBooks extends StatelessWidget {
  const WishlistBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        var cubit = context.read<WishlistCubit>();
        if (state is WishlistSuccessState) {
          var books = cubit.products;
          if (books.isEmpty) {
            return const Center(child: Text('No books in wishlist'));
          }
          return GridView.builder(
            itemCount: books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 11,
              crossAxisSpacing: 11,
              childAspectRatio: .6,
            ),
            itemBuilder: (context, index) {
              return BookCard(
                product: books[index],
                onRemoveFromWishlist: () {
                  cubit.removeFromWishlist(books[index].id ?? 0);
                },
                onRefresh: () {
                  cubit.getWishlist();
                },
              );
            },
          );
        } else {
          return GridShimmer(
            crossAxisCount: 2,
            mainAxisSpacing: 11,
            crossAxisSpacing: 11,
            childAspectRatio: .6,
            itemCount: 4,
            shrinkWrap: false,
          );
        }
      },
    );
  }
}
