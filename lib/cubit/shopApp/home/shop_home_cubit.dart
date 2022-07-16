import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/UI/shop_app/shop_layout/categories.dart';
import 'package:news_app/UI/shop_app/shop_layout/favorites.dart';
import 'package:news_app/UI/shop_app/shop_layout/home.dart';
import 'package:news_app/UI/shop_app/shop_layout/settings.dart';
import 'package:news_app/cubit/shopApp/home/shop_home_state.dart';
import 'package:news_app/network/cache_helper.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/network/end_points.dart';
import 'package:news_app/network/shop_data_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(HomeInitState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  HomeModel? homeModel;
  List<BottomNavigationBarItem> bottomNavigationItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Categories'),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border), label: 'Favoraties'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];
  List<Widget> screens = const [
    Home(),
    Categories(),
    Favorites(),
    Settings()
  ];

  void changeBottomNavigationIcon(int index) {
    currentIndex = index;
    emit(BottomNavigationChangeState());
  }

  Future<void> getHomeData() async {
    emit(HomeDataLoadingState());
    String? token = await CacheHelper.getData(key: 'token');
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      emit(HomeDataSuccessState());
    }).catchError((error) {
      emit(HomeDataErrorState());
    });
  }
}
