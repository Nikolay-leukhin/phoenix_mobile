part of 'store_cubit.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}
class StoreFail extends StoreState {}
class StoreSuccess extends StoreState {}
