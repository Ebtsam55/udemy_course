import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/UI/shop_app/login_screen.dart';
import 'package:news_app/UI/shop_app/onboarding_screen.dart';
import 'package:news_app/UI/shop_app/shop_layout/shop_layout.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_cubit.dart';
import 'package:news_app/themes.dart';
import 'UI/news_app/news_screen.dart';
import 'package:news_app/network/cache_helper.dart';
import 'package:news_app/network/dio_helper.dart';
import 'cubit/news_app/news_cubit.dart';
import 'cubit/news_app/news_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget startWidget;
  bool? onboarding = await CacheHelper.getData(key: 'onboarding');
  String? token = await CacheHelper.getData(key: 'token');
  if (onboarding ?? false) {
    startWidget = (token != null) ? ShopLayout() : const LoginScreen();
  } else {
    startWidget = OnboardingScreen();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({Key? key, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(create: (_) => NewsCubit()
            /* ..getSports()
              ..getBusiness()
              ..getScience()*/
            ),
        BlocProvider<ShopCubit>(create: (_) => ShopCubit()..getHomeData())
      ],
      child: BlocConsumer<NewsCubit, NewsState>(
          buildWhen: (_, state) => state is ModeChanged,
          listener: (_, __) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              themeMode: CacheHelper.getData(key: 'isDark') ?? false
                  ? ThemeMode.dark
                  : ThemeMode.light,
              darkTheme: darkTheme,
              theme: lightTheme,
              home: startWidget,
            );
          }),
    );
  }
}
