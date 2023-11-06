part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginState extends AuthState {}

class RegisterState extends AuthState {}


class AuthProcessState extends AuthState {}

class AuthFailState extends AuthState {}

class AuthSuccessState extends AuthState {}