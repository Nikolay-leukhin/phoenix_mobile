part of 'coin_transactions_cubit.dart';

@immutable
sealed class CoinTransactionsState {}

final class CoinTransactionsInitial extends CoinTransactionsState {}

final class CoinTransactionsLoading extends CoinTransactionsState {}


final class CoinTransactionsSuccess extends CoinTransactionsState {}


final class CoinTransactionsFailure extends CoinTransactionsState {}

