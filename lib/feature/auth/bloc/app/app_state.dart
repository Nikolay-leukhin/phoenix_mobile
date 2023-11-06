part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class AppUnAuthState extends AppState {}

class AppAuthState extends AppState {}


class EnterPinState extends AppState {}

class CreatePinState extends AppState {}