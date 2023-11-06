import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/profile/data/user_repository.dart';
import 'package:izobility_mobile/services/remote/api/api_service.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository;

  ProfileCubit(this._userRepository) : super(ProfileInitial()) {
    _userRepository.userDetailsDataStream.listen((event) {
      if (event == LoadingStateEnum.success) emit(ProfileSuccessState());
      if (event == LoadingStateEnum.loading) emit(ProfileWaiting());
      if (event == LoadingStateEnum.fail) emit(ProfileFailureState());
    });
  }

  Future<void> logout() async {
    emit(ProfileWaiting());

    try {
      await _userRepository.preferences.logout();
      emit(ProfileSuccessState());
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> changeUserGender(int genderIndex) async {
    _userRepository.user.details!.gender = genderIndex;
    emit(ProfileSuccessState());
  }

  Future<void> updateUserData({
    required String name,
    required String surname,
    required int gender,
    required String birthday,
  }) async {
    emit(ProfileWaiting());
    try {
      await _userRepository.updateUserData(
          name: name, surname: surname, gender: gender, birthday: birthday);
      await _userRepository.loadUserDetailsInfo();
      emit(ProfileSuccessState());
    } catch (ex) {
      print(ex);
      emit(ProfileFailureState());
    }
  }
}
