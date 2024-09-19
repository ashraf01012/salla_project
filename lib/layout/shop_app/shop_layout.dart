import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/shop_app/cubit/shop_cubit.dart';
import 'package:salla/modules/shop_app/login/shop_login_screen.dart';
import 'package:salla/modules/shop_app/search/search_screen.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/styles/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            title: const Text(
              'Salla',
              style: TextStyle(
                color: defaultColor,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(
                    context,
                    const SearchScreen(),
                  );
                },
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
