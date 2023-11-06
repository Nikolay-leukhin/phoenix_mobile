import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:meta/meta.dart';

part 'wallet_auth_state.dart';

class WalletAuthCubit extends Cubit<WalletAuthState> {
  final WalletRepository _walletRepository;

  WalletAuthCubit(this._walletRepository) : super(WalletAuthInitial());

  Future<void> authWalletBySeedPhrase(String seedPhrase) async {
    emit(WalletAuthLoadingState());

    try {
      await _walletRepository.enterWalletBySeedPhrase(seedPhrase);

      emit(WalletAuthSuccessState());
    } catch (ex) {
      log(ex.toString());

      emit(WalletAuthFailureState());
    }
  }
}
