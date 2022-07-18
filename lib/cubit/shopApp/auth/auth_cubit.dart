import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/cache_helper.dart';
import 'auth_state.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/network/end_points.dart';
import 'package:news_app/network/login_models.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(LoginInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);
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
        url: LOGIN, data: {'email': email, 'password': pass}).then((value) {
      CacheHelper.putData(
          key: 'token', value: LoginModel.fromJson(value?.data).data?.token);
      emit(LoginSuccessState(LoginModel.fromJson(value?.data)));
    }).catchError(
        (error){emit(LoginErrorState(error.toString()));});
  }

  Future<void> register({required String email, required String pass, required String phone , required String name }) async {
    emit(RegisterLoadingState());
    await DioHelper.postData(
        url: REGISTER, data: {'email': email, 'password': pass , 'name':name, 'phone':phone}).then((value) {
      CacheHelper.putData(
          key: 'token', value: LoginModel.fromJson(value?.data).data?.token);
      emit(RegisterSuccessState(LoginModel.fromJson(value?.data)));
    }).catchError(
            (error)  {print("################Error $error");
              emit(LoginErrorState(error.toString()));});
  }
}
