import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'coin_in_game_state.dart';

class CoinInGameCubit extends Cubit<CoinInGameState> {
  final WalletRepository walletRepository;

  CoinInGameCubit({required this.walletRepository})
      : super(CoinInGameInitial()) {
    walletRepository.emeraldInGameStream.stream.listen((event) {
      if (event == LoadingStateEnum.loading) emit(CoinInGameLoading());
      if (event == LoadingStateEnum.fail) emit(CoinInGameFail());
      if (event == LoadingStateEnum.success) emit(CoinInGameSuccess());
    });
  }
}
