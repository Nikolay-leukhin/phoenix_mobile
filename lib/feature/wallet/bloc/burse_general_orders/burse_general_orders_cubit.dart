import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'burse_general_orders_state.dart';

class BurseGeneralOrdersCubit extends Cubit<BurseGeneralOrdersState> {
  final WalletRepository walletRepository;

  BurseGeneralOrdersCubit(this.walletRepository)
      : super(BurseGeneralOrdersInitial()) {
    walletRepository.burseGeneralOrdersStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(BurseGeneralOrdersLoading());
      if (value == LoadingStateEnum.success) emit(BurseGeneralOrdersSuccess());
      if (value == LoadingStateEnum.fail) emit(BurseGeneralOrdersFailure());
    });
  }
}
