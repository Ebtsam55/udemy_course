import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_screen.dart';
import '../../cubit/news_app/news_cubit.dart';
import '../../cubit/news_app/news_state.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (_, __) {},
        builder: (context, __) {
          NewsCubit newsCubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("News"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SearchScreen()));
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      NewsCubit.get(context).changeMode();
                    },
                    icon: const Icon(Icons.brightness_4_outlined))
              ],
            ),
            body: newsCubit.screens[newsCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: newsCubit.currentIndex,
              items: newsCubit.bottomNavigationItems,
              onTap: (index) => newsCubit.changeBottomNavigationIcon(index),
            ),
          );
        });
  }
}
