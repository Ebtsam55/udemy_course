import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_state.dart';
import 'package:news_app/network/cache_helper.dart';
import 'package:news_app/network/dio_helper.dart';
import '../../widgets/news_app/business_news.dart';
import '../../widgets/news_app/scientific_news.dart';
import '../../widgets/news_app/settings.dart';
import '../../widgets/news_app/sports_news.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  bool isDark = false;
  List<BottomNavigationBarItem> bottomNavigationItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];
  List<Widget> screens = const [
    ScientificNews(),
    BusinessNews(),
    SportsNews(),
    Settings()
  ];

  void changeBottomNavigationIcon(int index) {
    currentIndex = index;
    emit(BottomNavigationState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> searchResult = [];
  Future<void> getSearchResult(String text) async {
    DioHelper.getData(url: 'v2/everything', query: {
      'q': text,
      'apiKey': 'e8be9acb260a4a0486232d368d60daee'
    }).then((value) {
      searchResult.clear();
      searchResult.addAll(value?.data['articles']);
      emit(GettingSearchResultSuccess());
    }).catchError((e) => print('Error is $e'));
  }


  Future<void> getBusiness() async {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'e8be9acb260a4a0486232d368d60daee'
    }).then((value) {
      business.addAll(value?.data['articles']);
      emit(GettingBusinessNewsSuccess());
    }).catchError((e) => print('Error is $e'));
  }

  Future<void> getSports() async {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'e8be9acb260a4a0486232d368d60daee'
    }).then((value) {
      sports.addAll(value?.data['articles']);
      emit(GettingSportsNewsSuccess());
    }).catchError((e) => print('Error is $e'));
  }

  Future<void> getScience() async {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'e8be9acb260a4a0486232d368d60daee'
    }).then((value) {
      science.addAll(value?.data['articles']);
      emit(GettingScienceNewsSuccess());
    }).catchError((e) => print('Error is $e'));
  }

  void changeMode() {
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark)
        .then((value) => emit(ModeChanged()));
  }
}
