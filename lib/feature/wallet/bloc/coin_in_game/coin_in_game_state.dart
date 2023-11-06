part of 'coin_in_game_cubit.dart';

@immutable
abstract class CoinInGameState {}

class CoinInGameInitial extends CoinInGameState {}

class CoinInGameLoading extends CoinInGameState {}

class CoinInGameFail extends CoinInGameState {}

class CoinInGameSuccess extends CoinInGameState {}
