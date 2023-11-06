part of 'password_recovery_cubit.dart';

abstract class PasswordRecoveryState {}

class PasswordRecoveryInitial extends PasswordRecoveryState {}


class PasswordRecoveryEmailSent extends PasswordRecoveryState {}

class PasswordRecoveryWait extends PasswordRecoveryState {
  int remainingTime;

  PasswordRecoveryWait({required this.remainingTime});
}

class PasswordRecoveryFailState extends PasswordRecoveryState {}

class PasswordRecoveryProcessState extends PasswordRecoveryState {}

class PasswordRecoverySuccessState extends PasswordRecoveryState {}

