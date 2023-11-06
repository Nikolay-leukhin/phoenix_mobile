import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'coins_on_chain_state.dart';

class CoinsOnChainCubit extends Cubit<CoinsOnChainState> {
  final WalletRepository walletRepository;

  CoinsOnChainCubit(this.walletRepository) : super(CoinsOnChainInitial()) {
    walletRepository.coinsOnChainStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(CoinsOnChainLoading());
      if (value == LoadingStateEnum.success) emit(CoinsOnChainSuccess());
      if (value == LoadingStateEnum.fail) emit(CoinsOnChainFailure());
    });
  }
}
