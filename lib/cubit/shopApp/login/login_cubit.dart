import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/network/end_points.dart';
import 'package:news_app/network/login_models.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isPasswordShown = true;
  IconData passSuffixIcon = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    passSuffixIcon = isPasswordShown
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(PasswordVisibilityStateChanged());
  }

  Future<void> login({required String email, required String pass}) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
            url: LOGIN, data: {'email': email, 'password': pass})
        .then((value) => {
              print("###### $value"),
              emit(LoginSuccessState(LoginModel.fromJson(value?.data)))
            })
        .catchError((error, stackTrace) => {
              print("######Error is ${error.toString()}"),
              emit(LoginErrorState(error.toString()))
            });
  }
}
