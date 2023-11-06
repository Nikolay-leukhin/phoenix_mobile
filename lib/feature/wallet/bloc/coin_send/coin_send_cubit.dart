import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'coin_send_state.dart';

class CoinSendCubit extends Cubit<CoinSendState> {
  final WalletRepository walletRepository;

  CoinSendCubit({required this.walletRepository}) : super(CoinSendInitial());

  Future<void> sendCoinOnChain(
      String address, double amount, int coinId) async {
    emit(CoinSendLoading());

    try {
      if (walletRepository.walletPage == 0) {
        await walletRepository.sendCoinOnChain(address, amount, coinId);

        await Future.delayed(Duration(seconds: 5)); // cuz we can't  listening the blocchain op-s 

        await walletRepository.getOnChainCoinsData();
      } else if (walletRepository.walletPage == 1) {
        await walletRepository.sendCoinInGame();

        await walletRepository.getGameTokens();
      }
      emit(CoinSendSuccess());
    } catch (ex) {
      print('-' * 10);
      print(ex);
      emit(CoinSendFailure());
    }
  }

  Future<void> changeTransferType() async {
    final currentType = walletRepository.transferType;
    if (currentType == TransferTypes.inGame) {
      walletRepository.transferType = TransferTypes.onChain;
    } else {
      walletRepository.transferType = TransferTypes.inGame;
    }
  }

  Future<void> sendInGameCoin(String email, int amount, int coinId) async {
    emit(CoinSendLoading());

    try {
      await walletRepository.sendInGameCoinByEmail(email, amount, coinId);
      emit(CoinSendSuccess());
    } catch (ex) {
      print(ex);
      emit(CoinSendFailure());
    }
  }

  Future<void> transferCoinGameChain(int coinId, double amount) async {
    emit(CoinSendLoading());

    try {
      if (walletRepository.transferType == TransferTypes.inGame) {
        await walletRepository.swapCoinInGameToOnChain(coinId, amount);

        await walletRepository.getGameTokens();
      } else {
        await walletRepository.swapCoinOnChainToInGame(coinId, amount);

        await Future.delayed(Duration(seconds: 5)); // cuz we can't  listening the blocchain op-s 
        await walletRepository.getOnChainCoinsData();
      }

      emit(CoinSendSuccess());
    } catch (ex) {
      print(ex);
      emit(CoinSendFailure());
    }
  }
}
