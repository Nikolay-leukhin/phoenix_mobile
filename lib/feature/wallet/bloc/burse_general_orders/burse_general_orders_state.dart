part of 'burse_general_orders_cubit.dart';

@immutable
sealed class BurseGeneralOrdersState {}

final class BurseGeneralOrdersInitial extends BurseGeneralOrdersState {}

final class BurseGeneralOrdersLoading extends BurseGeneralOrdersState {}

final class BurseGeneralOrdersSuccess extends BurseGeneralOrdersState {}

final class BurseGeneralOrdersFailure extends BurseGeneralOrdersState {}
