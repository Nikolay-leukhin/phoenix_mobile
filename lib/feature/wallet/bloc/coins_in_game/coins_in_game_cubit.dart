import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'coins_in_game_state.dart';

class CoinsInGameCubit extends Cubit<CoinsInGameState> {
  final WalletRepository walletRepository;

  CoinsInGameCubit(this.walletRepository) : super(CoinsInGameInitial()) {
    walletRepository.coinsInGameStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(CoinsInGameLoading());

      if (value == LoadingStateEnum.fail) emit(CoinsInGameFailure());

      if (value == LoadingStateEnum.success) emit(CoinsInGameSuccess());
    });
  }
}
