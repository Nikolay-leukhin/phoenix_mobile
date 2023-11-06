import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final StoreRepository storeRepository;

  StoreCubit({required this.storeRepository}) : super(StoreInitial()) {
    storeRepository.marketItemsStream.stream.listen((event) {
      if (event == LoadingStateEnum.loading) emit(StoreLoading());
      if (event == LoadingStateEnum.fail) emit(StoreFail());
      if (event == LoadingStateEnum.success) emit(StoreSuccess());
    });
  }
}
