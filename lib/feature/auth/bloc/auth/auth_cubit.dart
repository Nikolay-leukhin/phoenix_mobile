import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:izobility_mobile/models/login_data.dart';
import 'package:izobility_mobile/models/register_data.dart';

import '../../data/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial()) {
    checkLogin();
  }

  RegisterData? registerData;
  LoginData? loginData;

  bool userAlreadyRegistered = false;
  bool needChangePassword = false;

  void checkLogin() => authRepository.checkLogin();

  int? getUserId() => authRepository.userId;

  void _initialRegister(String email) {
    loginData = null;
    registerData = RegisterData(email: email);
  }

  void _initialLogin(String email) {
    registerData = null;
    loginData = LoginData(email: email);
  }

  Future<EmailStateEnum> checkEmail(String email, String? promo) async {
    final result = await authRepository.checkEmail(email, promo);

    userAlreadyRegistered = result == EmailStateEnum.registered;
    _initialLogin(email);
    emit(LoginState());

    return result;
  }

  void register() async {
    emit(AuthProcessState());
    try {
      await authRepository.register(registerData!);
      registerData = null;
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthFailState());
    }
  }

  Future login() async {
    emit(AuthProcessState());
    try {
      if (needChangePassword) {
        await authRepository.changePassword(
            email: loginData!.email, code: loginData!.password.toString());
      }
      await authRepository.login(loginData!);
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthFailState());
      rethrow;
    }
  }
}
