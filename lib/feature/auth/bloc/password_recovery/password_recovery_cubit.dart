import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../services/remote/api/api_service.dart';

part 'password_recovery_state.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  final ApiService apiService;

  PasswordRecoveryCubit({required this.apiService}) : super(PasswordRecoveryInitial());

  void resendRegisterEmail(int userId) async {
    int repeatDuration = 60;

    emit(PasswordRecoveryProcessState());
    try {
      await apiService.auth.resendVerificationCode(userId: userId);
      emit(PasswordRecoveryEmailSent());
      emit(PasswordRecoveryWait(remainingTime: repeatDuration));
      _startTimer(repeatDuration);
    } catch (e) {
      emit(PasswordRecoveryFailState());
      rethrow;
    }
  }

  void restorePassword(String email) async {
    int repeatDuration = 60;

    emit(PasswordRecoveryProcessState());
    try {
      await apiService.auth.restorePassword(email: email);

      emit(PasswordRecoveryEmailSent());
      emit(PasswordRecoveryWait(remainingTime: repeatDuration));
      _startTimer(repeatDuration);
    } catch (e) {
      emit(PasswordRecoveryFailState());
      rethrow;
    }
  }

  void changePassword(String password) async {
    emit(PasswordRecoveryProcessState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(PasswordRecoverySuccessState());
    } catch (e) {
      emit(PasswordRecoveryFailState());
    }
  }

  Future<bool> checkCode(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  void _startTimer(int time) async {
    const Duration duration = Duration(seconds: 1);

    Timer.periodic(duration, (timer) {
      if (time <= 0) {
        emit(PasswordRecoveryInitial());
        timer.cancel();
      } else {
        time--;
        emit(PasswordRecoveryWait(remainingTime: time));
      }
    });
  }
}
