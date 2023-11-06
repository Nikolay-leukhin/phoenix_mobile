import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/store/data/store_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';
import 'package:meta/meta.dart';

part 'store_user_items_state.dart';

class StoreUserItemsCubit extends Cubit<StoreUserItemsState> {
  final StoreRepository storeRepository;

  StoreUserItemsCubit(this.storeRepository) : super(StoreUserItemsInitial()) {
    storeRepository.userProductListStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(StoreUserItemsLoading());
      if (value == LoadingStateEnum.success) emit(StoreUserItemsSuccess());
      if (value == LoadingStateEnum.fail) emit(StoreUserItemsFailure());
    });
  }
}
