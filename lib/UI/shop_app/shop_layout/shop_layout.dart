import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/UI/shop_app/shop_layout/search_screen.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_cubit.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_state.dart';
import 'package:news_app/network/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (_, state) {},
        builder: (context, state) {
          ShopCubit shopCubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SearchScreen()));
                    },
                    icon: const Icon(Icons.search)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: shopCubit.currentIndex,
              items: shopCubit.bottomNavigationItems,
              onTap: (index) => shopCubit.changeBottomNavigationIcon(index),
            ),
            body: shopCubit.screens[shopCubit.currentIndex],
          );
        });
  }
}
