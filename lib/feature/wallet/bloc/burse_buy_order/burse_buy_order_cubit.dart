import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';

part 'burse_buy_order_state.dart';

class BurseBuyOrderCubit extends Cubit<BurseBuyOrderState> {
  final WalletRepository walletRepository;

  BurseBuyOrderCubit(this.walletRepository) : super(BurseBuyOrderInitial());

  void buyOrder(int orderId) async {
    emit(BurseBuyOrderLoading());

    try {
      await walletRepository.buyBurseOrder(orderId);

      emit(BurseBuyOrderSuccess());
    } catch (ex) {
      emit(BurseBuyOrderFailure());
    }
  }

  void cancelOrder(int orderId) async {
    emit(BurseBuyOrderLoading());

    try {
      await walletRepository.canselBurseOrder(orderId);

      emit(BurseBuyOrderSuccess());
    } catch (ex) {
      emit(BurseBuyOrderFailure());
    }
  }
}
