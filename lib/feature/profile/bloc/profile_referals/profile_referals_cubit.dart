import 'package:bloc/bloc.dart';
import 'package:phoenix_mobile/feature/profile/data/user_repository.dart';
import 'package:meta/meta.dart';

part 'profile_referals_state.dart';

class ProfileReferalsCubit extends Cubit<ProfileReferalsState> {
  final UserRepository userRepository;

  ProfileReferalsCubit(this.userRepository) : super(ProfileReferalsInitial());

  Future<void> loadReferalList() async {
    emit(ProfileReferalsLoading());

    try {
      await userRepository.loadReferalsList();
      emit(ProfileReferalsSuccess());
    } catch (ex) {
      print(ex);
      emit(ProfileReferalsFailure());
    }
  }
}
