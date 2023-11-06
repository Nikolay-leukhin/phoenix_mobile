import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/main/data/main_repository.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  final MainScreenRepository repository;

  MainScreenCubit({required this.repository}) : super(MainScreenInitial()) {
    repository.loadingState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) emit(MainScreenPreviewLoading());
      if (event == LoadingStateEnum.fail) emit(MainScreenPreviewFail());
      if (event == LoadingStateEnum.success) emit(MainScreenPreview());
    });
  }
}
