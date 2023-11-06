part of 'coins_in_game_cubit.dart';

@immutable
sealed class CoinsInGameState {}

final class CoinsInGameInitial extends CoinsInGameState {}

final class CoinsInGameLoading extends CoinsInGameState {}

final class CoinsInGameSuccess extends CoinsInGameState {}

final class CoinsInGameFailure extends CoinsInGameState {}


