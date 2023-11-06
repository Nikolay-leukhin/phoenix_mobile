import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/models/market_item.dart';
import 'package:meta/meta.dart';

part 'store_item_state.dart';

class StoreItemCubit extends Cubit<StoreItemState> {
  final StoreRepository storeRepository;

  StoreItemCubit({required this.storeRepository}) : super(StoreItemInitial()) {}

  void loadMarketItemInfo(int id) async {
    emit(StoreItemLoadingState());

    final MarketItemModel? marketItem =
        await storeRepository.getMarketItemInfoById(id);

    if (marketItem == null) {
      emit(StoreItemFailureState());
    } else {
      storeRepository.lastOpenedMarketItem = marketItem;
      emit(StoreItemSuccessState());
    }
  }
}