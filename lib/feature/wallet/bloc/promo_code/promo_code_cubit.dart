import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/wallet/data/wallet_repository.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';
import 'package:meta/meta.dart';

part 'promo_code_state.dart';

class PromoCodeCubit extends Cubit<PromoCodeState> {
  final ApiService apiService;
  final WalletRepository walletRepository;

  PromoCodeCubit({required this.apiService, required this.walletRepository})
      : super(PromoCodeInitial());

  void activateCode(String code) async {
    emit(PromoActivateProcessState());
    try {
      final promoResponse = await apiService.shop.activatePromoCode(code);
      print("promo ${promoResponse}");
      walletRepository.loadEmeraldCoin();
      walletRepository.getGameTokens();
      emit(PromoActivatedState(
          coinName: promoResponse['monet'], coinAmount: promoResponse['id'].toString()));
    } catch (e) {
      print(e);
      emit(PromoInvalidState());
      rethrow;
    }
  }
}
