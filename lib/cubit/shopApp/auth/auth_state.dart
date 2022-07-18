import 'package:news_app/network/login_models.dart';

abstract class AuthStates {}

class LoginInitialState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  LoginModel model;

  LoginSuccessState(this.model);
}

class LoginLoadingState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error;

  LoginErrorState(this.error);
}

class PasswordVisibilityStateChanged extends AuthStates {}

class RegisterSuccessState extends AuthStates {
  LoginModel model;

  RegisterSuccessState(this.model);
}

class RegisterLoadingState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String error;

  RegisterErrorState(this.error);
}
