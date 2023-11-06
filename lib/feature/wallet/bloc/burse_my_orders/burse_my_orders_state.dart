part of 'burse_my_orders_cubit.dart';

@immutable
sealed class BurseMyOrdersState {}

final class BurseMyOrdersInitial extends BurseMyOrdersState {}

final class BurseMyOrdersLoading extends BurseMyOrdersState {}

final class BurseMyOrdersSuccess extends BurseMyOrdersState {}

final class BurseMyOrdersFailure extends BurseMyOrdersState {}

