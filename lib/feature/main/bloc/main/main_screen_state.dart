part of 'main_screen_cubit.dart';

@immutable
abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}

class MainScreenPreviewLoading extends MainScreenState {}

class MainScreenPreview extends MainScreenState {}

class MainScreenPreviewFail extends MainScreenState {}