import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'burse_my_orders_state.dart';

class BurseMyOrdersCubit extends Cubit<BurseMyOrdersState> {
  final WalletRepository walletRepository;

  BurseMyOrdersCubit(this.walletRepository) : super(BurseMyOrdersInitial()) {
    walletRepository.burseMyOrdersStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(BurseMyOrdersLoading());
      if (value == LoadingStateEnum.success) emit(BurseMyOrdersSuccess());
      if (value == LoadingStateEnum.fail) emit(BurseMyOrdersFailure());
    });
  }
}
