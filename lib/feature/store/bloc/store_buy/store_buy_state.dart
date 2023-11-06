part of 'store_buy_cubit.dart';

@immutable
sealed class StoreBuyState {}

final class StoreBuyInitial extends StoreBuyState {}


final class StoreBuyLoading extends StoreBuyState {}


final class StoreBuySuccess extends StoreBuyState {}


final class StoreBuyFailure extends StoreBuyState {}


