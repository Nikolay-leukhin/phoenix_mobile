import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/main/data/notification_repository.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _notificationsRepository;

  NotificationsCubit(this._notificationsRepository)
      : super(NotificationsInitial());

  Future<void> loadNotifications() async {
    emit(NotificationsWaitingState());
    try {
      await _notificationsRepository.loadNotificationList();
      emit(NotificationsLoadedSuccessState());
    } catch (e) {
      print(e.toString());
      emit(NotificationsLoadedFailureState());
      rethrow;
    }
  }

  void changeFilterCategory(int categoryIndex) {
    _notificationsRepository.currentFilterIndex = categoryIndex;
    // TODO make function of sorting list accroding to new category
    emit(NotificationsLoadedSuccessState());
  }
}
