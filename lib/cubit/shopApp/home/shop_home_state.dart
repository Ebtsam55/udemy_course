import 'package:news_app/model/shop_models/login_models.dart';

abstract class ShopState {}

class HomeInitState extends ShopState {}

class BottomNavigationChangeState extends ShopState {}

class HomeDataSuccessState extends ShopState {}

class HomeDataErrorState extends ShopState {}

class HomeDataLoadingState extends ShopState {}

class GetCategoriesSuccessState extends ShopState {}

class GetCategoriesErrorState extends ShopState {}

class GetCategoriesLoadingState extends ShopState {}
class GetUserDataSuccessState extends ShopState {
}

class GetUserDataErrorState extends ShopState {}

class GetUserDataLoadingState extends ShopState {}

class UpdateUserDataSuccessState extends ShopState {
}

class UpdateUserDataErrorState extends ShopState {}

class UpdateUserDataLoadingState extends ShopState {}