import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:meta/meta.dart';

part 'store_buy_state.dart';

class StoreBuyCubit extends Cubit<StoreBuyState> {
  final StoreRepository storeRepository;

  StoreBuyCubit(this.storeRepository) : super(StoreBuyInitial());

  void buyProduct(int id) async {
    emit(StoreBuyLoading());

    try {
      await storeRepository.buyProduct(id);
      emit(StoreBuySuccess());
    } catch (ex) {
      emit(StoreBuyFailure());
    }
  }
}
