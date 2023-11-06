part of 'games_cubit.dart';

@immutable
sealed class GamesState {}

final class GamesInitial extends GamesState {}

final class GamesWaitingState extends GamesState {}

final class GamesLoadedSuccessState extends GamesState {}

final class GamesLoadedFailureState extends GamesState {}
