import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/games/data/games_repository.dart';

part 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  final GamesRepository _gamesRepository;

  GamesCubit(this._gamesRepository) : super(GamesInitial());

  void loadGameDetails(int gameId) async {
    emit(GamesWaitingState());
    await Future.delayed(const Duration(seconds: 1));

    emit(GamesLoadedSuccessState());
  }
}
