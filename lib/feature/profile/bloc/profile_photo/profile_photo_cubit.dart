import 'package:bloc/bloc.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile/profile_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:meta/meta.dart';

part 'profile_photo_state.dart';

class ProfilePhotoCubit extends Cubit<ProfilePhotoState> {
  final UserRepository _userRepository;

  ProfilePhotoCubit(this._userRepository) : super(ProfilePhotoInitial());

  void updatePhoto(String imageBase64) async {
    emit(ProfilePhotoLoading());

    try {
      await _userRepository.updatePhoto(imageBase64);

      emit(ProfilePhotoFailure());
    } catch (ex) {
      print(ex);
      emit(ProfilePhotoFailure());
    }
  }
}
