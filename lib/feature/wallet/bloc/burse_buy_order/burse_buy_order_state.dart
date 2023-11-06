part of 'burse_buy_order_cubit.dart';

@immutable
sealed class BurseBuyOrderState {}

final class BurseBuyOrderInitial extends BurseBuyOrderState {}

final class BurseBuyOrderLoading extends BurseBuyOrderState {}

final class BurseBuyOrderSuccess extends BurseBuyOrderState {}

final class BurseBuyOrderFailure extends BurseBuyOrderState {}

