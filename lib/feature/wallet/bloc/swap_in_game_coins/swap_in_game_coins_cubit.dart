import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';

part 'swap_in_game_coins_state.dart';

class SwapInGameCoinsCubit extends Cubit<SwapInGameCoinsState> {
  final WalletRepository walletRepository;

  SwapInGameCoinsCubit({required this.walletRepository})
      : super(SwapInGameCoinsInitial());

  void swapInGameCoins(int amount, int idToCoin, int idFromCoin) async{
    emit(SwapInGameCoinsLoading());

    try {
      await walletRepository.swapInGameCoins(amount, idToCoin, idFromCoin);
    } catch (e){
      emit(SwapInGameCoinsFail());
    }
  }
}
