import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:izobility_mobile/feature/profile/bloc/profile_links/profile_links_cubit.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:meta/meta.dart';

part 'profile_phone_change_state.dart';

class ProfilePhoneChangeCubit extends Cubit<ProfilePhoneChangeState> {
  final UserRepository userRepository;

  ProfilePhoneChangeCubit(this.userRepository)
      : super(ProfilePhoneChangeInitial());

  Future<void> verifyUserPhone(
      {required String countryCode, required String phoneNumber}) async {
    emit(ProfilePhoneChangeLoading());
    try {
      await userRepository.validateUserPhone(countryCode, phoneNumber);
      emit(ProfilePhoneChangeSuccess());
    } catch (ex) {
      print(ex);
      emit(ProfilePhoneChangeFailure(errorText: "Номер уже внесен"));
    }
  }

  Future<void> validatePhoneCode(String code) async {
    emit(ProfilePhoneChangeCodeLoading());

    try {
      await userRepository.validatePhoneCode(code);
      await userRepository.loadUserDetailsInfo();
      emit(ProfilePhoneChangeCodeSuccess());
    } catch (ex) {
      emit(ProfilePhoneChangeCodeFailure(errorText: "Неверный код"));
    }
  }
}
