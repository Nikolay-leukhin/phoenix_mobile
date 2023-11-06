import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';

part 'coin_transactions_state.dart';

class CoinTransactionsCubit extends Cubit<CoinTransactionsState> {
  final WalletRepository walletRepository;

  CoinTransactionsCubit(this.walletRepository)
      : super(CoinTransactionsInitial());

  void getCoinTransactions(String address) async {
    emit(CoinTransactionsLoading());

    try {
      await walletRepository.getCoinOperations(address);

      emit(CoinTransactionsSuccess());
    } catch (ex) {
      print(ex);
      emit(CoinTransactionsFailure());
    }
  }
}
