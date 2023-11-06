part of 'store_user_items_cubit.dart';

@immutable
sealed class StoreUserItemsState {}

final class StoreUserItemsInitial extends StoreUserItemsState {}

final class StoreUserItemsLoading extends StoreUserItemsState {}

final class StoreUserItemsFailure extends StoreUserItemsState {}

final class StoreUserItemsSuccess extends StoreUserItemsState {}

