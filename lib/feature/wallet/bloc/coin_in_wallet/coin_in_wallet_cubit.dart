import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'coin_in_wallet_state.dart';

class CoinInWalletCubit extends Cubit<CoinInWalletState> {
  final WalletRepository walletRepository;

  CoinInWalletCubit(this.walletRepository) : super(CoinInWalletInitial()) {
    walletRepository.emeraldInWalletStream.stream.listen((event) {
      if (event == LoadingStateEnum.loading) emit(CoinInWalletLoadingState());
      if (event == LoadingStateEnum.fail) emit(CoinInWalletLoadedFailureState());
      if (event == LoadingStateEnum.success) emit(CoinInWalletLoadedSuccessState());
    });
  }
}
