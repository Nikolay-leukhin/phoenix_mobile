part of 'swap_in_game_coins_cubit.dart';

@immutable
abstract class SwapInGameCoinsState {}

class SwapInGameCoinsInitial extends SwapInGameCoinsState {}

class SwapInGameCoinsLoading extends SwapInGameCoinsState {}

class SwapInGameCoinsFail extends SwapInGameCoinsState {}

class SwapInGameCoinsSuccess extends SwapInGameCoinsState {}