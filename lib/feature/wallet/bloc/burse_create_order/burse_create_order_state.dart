part of 'burse_create_order_cubit.dart';

@immutable
sealed class BurseCreateOrderState {}

final class BurseCreateOrderInitial extends BurseCreateOrderState {}

final class BurseCreateOrderLoading extends BurseCreateOrderState {}

final class BurseCreateOrderSuccess extends BurseCreateOrderState {}

final class BurseCreateOrderFailure extends BurseCreateOrderState {}
