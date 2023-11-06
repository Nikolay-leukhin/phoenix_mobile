part of 'store_item_cubit.dart';

@immutable
sealed class StoreItemState {}

final class StoreItemInitial extends StoreItemState {}

final class StoreItemLoadingState extends StoreItemState {}

final class StoreItemSuccessState extends StoreItemState {}

final class StoreItemFailureState extends StoreItemState {}
