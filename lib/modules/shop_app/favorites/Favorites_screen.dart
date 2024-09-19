import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/shop_app/cubit/shop_cubit.dart';
import 'package:salla/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);

        var favoritesList = shopCubit.favoritesModel?.data?.data ?? [];

        return ConditionalBuilder(
          condition: favoritesList.isNotEmpty,
          builder: (context) {
            return ListView.separated(
              itemBuilder: (context, index) {
                var product = favoritesList[index].product;
                if (product != null) {
                  return buildListProduct(product, context);
                } else {
                  return const SizedBox.shrink();
                }
              },
              separatorBuilder: (context, index) => myDivider(),
              itemCount: favoritesList.length,
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
