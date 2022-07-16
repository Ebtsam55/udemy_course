import 'package:news_app/network/login_models.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginModel model;
  LoginSuccessState(this.model);
}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);

}

class PasswordVisibilityStateChanged extends LoginState{}
