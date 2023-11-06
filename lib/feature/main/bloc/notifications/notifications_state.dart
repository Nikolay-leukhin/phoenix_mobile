part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsWaitingState extends NotificationsState {}

final class NotificationsLoadedSuccessState extends NotificationsState {}

final class NotificationsLoadedFailureState extends NotificationsState {}

final class NotificationsFiltersUpdated extends NotificationsState {}