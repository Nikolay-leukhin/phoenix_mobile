part of 'coin_send_cubit.dart';

@immutable
sealed class CoinSendState {}

final class CoinSendInitial extends CoinSendState {}

final class CoinSendLoading extends CoinSendState {}

final class CoinSendSuccess extends CoinSendState {}

final class CoinSendFailure extends CoinSendState {}
